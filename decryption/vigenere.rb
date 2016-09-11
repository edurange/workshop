#VIGENERE CIPHER-Polyalphabetic Substitution
#
#The letters in a chosen key word determine the shift values 
#between the letters in the plain text and the letters in the 
#encrypted text.

#Description : Currently the program is designed to encrypt a 
#user-inputted plaintext using a user-inputted encryption key.
#Next steps :  Have plain_text and key come from an established file.


class Vigenere
    attr_reader :key
    ALPHA_BASE ||= "A".ord
    ALPHABET_SIZE ||= 26


    def initialize(key_string)
        @key = string_to_int_array key_string.upcase!
    end


    def encrypt(plaintext, key)
        plaintext_int_array = string_to_int_array plaintext.upcase
        encrypted_int_array = []
        plaintext_int_array.each_with_index do |letter, i|
            encrypted_int = (letter + @key[i % @key.size]) % ALPHABET_SIZE + ALPHA_BASE
	    encrypted_int_array << encrypted_int
        end
    return int_array_to_string encrypted_int_array
    end

    def decrypt(ciphertext, key)
        ciphertext_int_array = string_to_int_array ciphertext.upcase
        decrypted_int_array = []
        ciphertext_int_array.each_with_index do |letter, i|
            decrypted_int = (letter - @key[i % @key.size]) % ALPHABET_SIZE + ALPHA_BASE
	    decrypted_int_array << decrypted_int
        end
    return int_array_to_string decrypted_int_array
    end


    def string_to_int_array(string)
        string.chars.map { |char| char.ord }
    end

    def int_array_to_string(int_array)
        int_array.map { |int| int.chr }.join
    end

end



puts "Enter plaintext "
plaintextin = gets.chomp
puts "Enter key " 
keyin = gets.chomp
b = Vigenere.new(keyin)
cipher = b.encrypt(plaintextin, keyin)
cipher.each_byte{|b| print b.chr}
print "\n"
decipher = b.decrypt(cipher, keyin)
decipher.each_byte{|b| print b.chr}
print "\n"


