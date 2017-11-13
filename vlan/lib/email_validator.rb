class EmailValidator

    def valid?(email)
        !!(email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end

end