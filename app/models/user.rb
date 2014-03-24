class User
  attr_reader :first_name, :last_name, :dob

  def initialize(first_name: '', last_name: '', dob: nil)
    @first_name = first_name
    @last_name = last_name
    @dob = dob
  end
end
