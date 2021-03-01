# dependencies
require "active_support"

# modules
require "delete_in_batches/version"

module DeleteInBatches
  # TODO use keyword arguments
  def delete_in_batches(options = {})
    batch_size = options[:batch_size] || 10000

    pk       = "#{quoted_table_name}.#{quoted_primary_key}"
    sql_proc = proc { select(pk).limit(batch_size).to_sql }
    sql      = connection.try(:unprepared_statement, &sql_proc) || sql_proc.call

    if %w(MySQL Mysql2 Mysql2Spatial).include?(connection.adapter_name)
      sql = "SELECT * FROM (#{sql}) AS t"
    end

    unless connection.adapter_name =~ /postg/i
      # TODO raise error
      warn "[delete_in_batches] Use in_batches(of: #{batch_size.to_i}).delete_all instead of this gem for non-Postgres databases"
    end

    while connection.delete("DELETE FROM #{quoted_table_name} WHERE #{pk} IN (#{sql})") == batch_size
      yield if block_given?
      sleep(options[:sleep]) if options[:sleep]
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend DeleteInBatches
end
