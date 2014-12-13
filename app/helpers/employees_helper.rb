module EmployeesHelper
  # Returns the Gravatar for the given employee.
  def gravatar_for(employee)
  	gravatar_id=Digest::MD5.hexdigest(employee.email.downcase)
  	gravatar_url="http://www.gravatar.com/avatar/#{gravatar_id}"
  	image_tag(gravatar_url, alt:employee.name, class:"gravatar")
  end
end
