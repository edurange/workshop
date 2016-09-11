SeqPair = Struct.new(:sequence, :index, :spacing)

class VigenereTool
	def initialize(message)
		@message = message
		@sequencesTemp = Hash.new
		@sequences = Hash.new
		@sequenceSpacing = Array.new(21, 0)
		@message_length = message.length
		@probable_key_length = 0
	end


	def sub_sequences(seq_max)
		if seq_max < 3
			puts("Error: Can't test for sequence lengths less than 3.")
		elsif seq_max > @message_length
			puts("Error: Can't test for sequence length that is longer than the message.")
		else
			for i in 3..seq_max
				for j in 0..(@message_length - i)
					tempSeq = @message[j, i]
					if @sequencesTemp.has_key?(tempSeq) && !@sequences.has_key?(tempSeq)
						@sequences[tempSeq] = SeqPair.new(tempSeq, j, j - @sequencesTemp[tempSeq].index)
					else
						@sequencesTemp[tempSeq] = SeqPair.new(tempSeq, j)
					end
				end
			end
		end

		@sequences.each do |key, val|
			for i in 3..20
				if val.spacing % i == 0
					@sequenceSpacing[i] += 1
				end
			end
		end
	end

	def print_sub_sequences
		@sequences.each do |seq|
			puts(seq)
		end
	end

	def print_spacing
		max_frequency = 0
		for i in 3..20
			spacing = @sequenceSpacing[i]
			if spacing > max_frequency
				max_frequency = spacing
				@probable_key_length = i
			end
			puts("Number of sequences for key length #{i}: #{@sequenceSpacing[i]}")
		end
		puts("The key length is likely: #{@probable_key_length}\n")
	end
end

encryption = File.read "#{ARGV[0]}"
v = VigenereTool.new(encryption)
v.sub_sequences(4)
v.print_sub_sequences
print("\n\n")
v.print_spacing