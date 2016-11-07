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
    ALPHA_LAST = ALPHA_BASE + ALPHABET_SIZE
    @unreadable_characters = false

    def initialize(key_string)
        @key = string_to_int_array key_string.upcase!
    end

    # This removes spaces and ALL special characters. Only letters make it through.
    def encrypt_no_spaces(plaintext)
        return encrypt(plaintext, false)
    end

    def encrypt(plaintext, spaces=true)
        plaintext_int_array = string_to_int_array plaintext.upcase
        encrypted_int_array = []
        nospaces_int_array = []
        key_location = 0

        plaintext_int_array.each do |letter|
            if letter.between?(ALPHA_BASE, ALPHA_LAST)
                encrypted_int = (letter + @key[key_location % @key.size]) % ALPHABET_SIZE + ALPHA_BASE
                encrypted_int_array << encrypted_int
                key_location = key_location + 1 % @key.size
            elsif letter.between?(32, 126)
                if spaces
                    encrypted_int_array << letter
                end
            else
                @unreadable_characters = true
            end
        end
        char_error_message if @unreadable_characters
    return int_array_to_string encrypted_int_array
    end

    def decrypt(ciphertext)
        ciphertext_int_array = string_to_int_array ciphertext.upcase
        decrypted_int_array = []
        key_location = 0
        ciphertext_int_array.each do |letter|
            if letter.between?(ALPHA_BASE, ALPHA_LAST)
                decrypted_int = (letter - @key[key_location % @key.size]) % ALPHABET_SIZE + ALPHA_BASE
                decrypted_int_array << decrypted_int
                key_location = key_location + 1 % @key.size
            elsif letter.between?(32, 126)
                decrypted_int_array << letter
            end
        end
    return int_array_to_string decrypted_int_array
    end

    def string_to_int_array(string)
        string.chars.map { |char| char.ord }
    end

    def int_array_to_string(int_array)
        int_array.map { |int| int.chr }.join
    end

    def char_error_message
        puts("The plaintext that was input contained characters that could not be read. They were ommited from the text before encryption.")
    end

end

