require "delete_in_batches/version"
require "active_record"

module DeleteInBatches
  def delete_in_batches(options = {})
    batch_size = options[:batch_size] || 10000

    pk       = "#{quoted_table_name}.#{quoted_primary_key}"
    sql_proc = proc { select(pk).limit(batch_size).to_sql }
    sql      = connection.try(:unprepared_statement, &sql_proc) || sql_proc.call

    while connection.delete("DELETE FROM #{quoted_table_name} WHERE #{pk} IN (#{sql})") == batch_size
      yield if block_given?
    end
  end
end

ActiveRecord::Base.send :extend, DeleteInBatches
