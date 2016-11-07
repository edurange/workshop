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

	# Finds the Index of Coincidence for a string
	def indexCoincidence(string)
		# counts how often each letter is found
		alphaCount = Array.new(26, 0)
		letters = 0.0
		icTop = 0.0
		string.each_char do |c|
			letters += 1
			alphaCount[c.downcase.ord - 97] += 1
		end

		alphaCount.each do |x|
			if x > 1
				icTop += x * (x - 1)
			end
		end
		icBottom = letters * (letters - 1)
		return (icTop / icBottom)
	end

	def key_length_find(message, maxKeyLength)
		message.downcase.gsub(/\W+/, '')
		averageIC = Array.new(maxKeyLength + 1, 0)
		for i in 2..maxKeyLength
			substrings = Array.new(i, "")
			for j in 0..(message.length - 1)
				substrings[j % i] += message[j]
			end
			# test I.C. of all substring[j] and average
			ics = Array.new(i, 0)
			for j in 0..(i - 1)
				ics[j] = indexCoincidence(substrings[j])
			end
			icTotal = 0.0
			ics.each {|x| icTotal += x}
			averageIC[i] = icTotal / ics.length
			puts("#{i} - #{averageIC[i]}")
		end
		averageAllIC = 0
		averageIC.each {|x| averageAllIC += x}
		averageAllIC = averageAllIC / averageIC.length
		puts averageAllIC
	end

	
end

#encryption = File.read "#{ARGV[0]}"
#v = VigenereTool.new(encryption)
#v.key_length_find("RIKVBIYBITHUSEVAZMMLTKASRNHPNPZICSWDSVMBIYFQEZUBZPBRGYNTBURMBECZQKBMBPAWIXSOFNUZECNRAZFPHIYBQEOCTTIOXKUNOHMRGCNDDXZWIRDVDRZYAYYICPUYDHCKXQIECIEWUICJNNACSAZZZGACZHMRGXFTILFNNTSDAFGYWLNICFISEAMRMORPGMJLUSTAAKBFLTIBYXGAVDVXPCTSVVRLJENOWWFINZOWEHOSRMQDGYSDOPVXXGPJNRVILZNAREDUYBTVLIDLMSXKYEYVAKAYBPVTDHMTMGITDZRTIOVWQIECEYBNEDPZWKUNDOZRBAHEGQBXURFGMUECNPAIIYURLRIPTFOYBISEOEDZINAISPBTZMNECRIJUFUCMMUUSANMMVICNRHQJMNHPNCEPUSQDMIVYTSZTRGXSPZUVWNORGQJMYNLILUKCPHDBYLNELPHVKYAYYBYXLERMMPBMHHCQKBMHDKMTDMSSJEVWOPNGCJMYRPYQELCDPOPVPBIEZALKZWTOPRYFARATPBHGLWWMXNHPHXVKBAANAVMNLPHMEMMSZHMTXHTFMQVLILOVVULNIWGVFUCGRZZKAUNADVYXUDDJVKAYUYOWLVBEOZFGTHHSPJNKAYICWITDARZPVU", 40)
# v.sub_sequences(4)
# v.print_sub_sequences 
# print("\n\n")
# v.print_spacing