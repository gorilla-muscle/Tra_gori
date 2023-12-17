module ApplicationHelper
  def flash_class(type)
    case type
    when 'success' then 'bg-green-500 text-white p-4 rounded-md'
    when 'alert' then 'bg-red-500 text-white p-4 rounded-md'
    when 'info' then 'bg-blue-500 text-white p-4 rounded-md'
    when 'warning' then 'bg-yellow-500 text-white p-4 rounded-md'
    end
  end
end
