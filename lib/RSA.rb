require "prime"

class RSA
    @n_
    @e_
    @d_
    def initialize n, e, d
        #initializes this instance of RSA with a n,e and d 
        #variables of type int. 'n','e' are the public key 
        #and 'd' is the private one. This n,e,d should be 
        #used when encrypting and decrypting the message
        @n_ = n
        @e_ = e
        @d_ = d
    end
   
    def n
        #returns the value of 'n' passed in the initialize
        return @n_
    end
     
    def e
        #returns the value of 'e' passed in the initialize
        return @e_
    end
   
    def d
        #returns the value of 'd' passed in the initialize
        return @d_
    end
   
    def new_key
        #generates a new 'n','e' and 'd' values following the 
        #RSA algorithm. Returns a new array of three elements 
        #where the first element is 'n', the second is 'e' and 
        #the third is 'd'. Each time it is called a new key 
        #must be returned.
        prng = Random.new
        p = (Prime.first 120)[10 + prng.rand(110)]
        q = (Prime.first 120)[10 + prng.rand(110)]
        n = p * q
        coprime = Array.new
        lcm = (p - 1).lcm(q - 1)
        for i in 2..lcm
            if i.gcd(lcm) == 1
                coprime << i
            end
        end
        e = coprime[prng.rand(coprime.size)]
        d = 0
        for i in 2..lcm
            if (i * e) % lcm == 1
                d = i
                break
            end
        end

        keys = [n, e, d]
        return keys
    end
   
    def encrypt message
        #encrypts the message passed. The message is of type 
        #string. Encrypts each symbol of this string by using 
        #its ASCII number representation and returns the 
        #encrypted message.
        encr = Array.new
        message.each_char do |ch|
            encr << ch.ord ** @e_ % @n_
        end
        encr = encr.to_s[1..-2]
        encr = encr.tr " ", ""
        return encr
    end
   
    def decrypt message
        #decrypts the message passed. The message is of type
        #string. Decrypts each symbol of this string Encrypts 
        #each symbol of this string by using its ASCII number 
        #representationand returns the decrypted message. 
        decr = String.new
        message.split(',').each do |num|
            num = num.to_i
            decr << (num ** @d_ % @n_).chr
        end
        return decr

    end 
end
