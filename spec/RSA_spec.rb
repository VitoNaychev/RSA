require "RSA"

describe RSA do
    describe "Initialization and key returns" do
        rsa = RSA.new 3, 5, 7
        context "Calling .n" do
            it "returns 3" do
                expect(rsa.n).to eql 3
            end
        end
        context "Calling .e" do
            it "returns 5" do
                expect(rsa.e).to eql 5
            end
        end
        context "Calling .d" do
            it "returns 7" do
                expect(rsa.d).to eql 7
            end
        end
    end
    describe "Key generator" do
        context "Calling new_key" do
            it "returns an array with 3 elements" do
                expect(RSA.new(0, 0, 0).new_key.length).to eql 3
            end
        end
        context "Calling new_key two times" do
            it "generates different results" do
                rsa = RSA.new 0, 0, 0
                frs_keys = rsa.new_key
                sec_keys = rsa.new_key
                
                expect(rsa.new_key <=> rsa.new_key).to_not eql 0 
            end
        end
    end

    describe "Encrypt" do
        keys = RSA.new(0, 0, 0).new_key
        rsa = RSA.new keys[0], keys[1], keys[2]
        context "Calling encrypt on a message" do
            it "returns numbers with count equaling the length of message" do
                str = "this is a short message"
                expect(rsa.encrypt(str).split(",").size).to eql str.length
            end
        end
        context "Calling encrypt on a empty string" do
            it "returns an empty string" do 
                expect(rsa.encrypt("")).to eql ""
            end
        end
    end
    describe "Decrypt" do
        keys = RSA.new(0, 0, 0).new_key
        rsa = RSA.new keys[0], keys[1], keys[2]
        context "Calling decrypt on an empty string" do
            it "returns an empty string" do
                expect(rsa.decrypt("")).to eql ""
            end
        end
    end
    describe "Encrypt-Decrypt Commutativity" do
        keys = RSA.new(0, 0, 0).new_key
        rsa = RSA.new keys[0], keys[1], keys[2]
        context "Calling encrypt and then decrypt on a string" do
            it "returns the primary string" do
                str = "This is a very short string although I will make it longer"
                encr = rsa.encrypt(str);
                expect(rsa.decrypt(encr)).to eql str
            end
        end 
    end
end
