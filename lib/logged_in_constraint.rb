module LoggedInConstraint
  class User < Struct.new(:value)
    def matches?(request)
      someone_is_logged_in = request.env["warden"].authenticate?(scope: :user)
      someone_is_logged_in == value
    end
  end
end
