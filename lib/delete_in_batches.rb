require "delete_in_batches/version"

module DeleteInBatches

  def delete_in_batches(options = {}, &block)
    batch_size = options[:batch_size] || 10000

    # TODO dry
    sql =
      if connection.respond_to?(:unprepared_statement)
        # ActiveRecord 4
        connection.unprepared_statement do
          select(:id).limit(batch_size).to_sql
        end
      else
        select(:id).limit(batch_size).to_sql
      end

    while connection.delete("DELETE FROM #{table_name} WHERE id IN (#{sql})") == batch_size
      yield if block_given?
    end
  end

end

ActiveRecord::Base.send :extend, DeleteInBatches
