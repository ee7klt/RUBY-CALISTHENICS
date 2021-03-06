#John Meehan 
#Metaprogramming
# define a method attr_accessor_with_history that provised same funciotnality as attr_accessor but also tracks every value tha attribute has ever had
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    class_eval %Q{ 
		#a method class_eval that takes a string and evaluates it in the context of the current class, 
		#that is, the class from which you're calling
		def #{attr_name}=(attr_name)
			# a setter for whatever attr_name is 
			@attr_name = attr_name

			#history functionality
			if @#{attr_name}_history
				@#{attr_name}_history << attr_name #puts it into the history array of this func
			else
				#a previously not seen attr make an array and add it to it
				@#{attr_name}_history = Array.new
				
				@#{attr_name}_history << nil # added this as the grader wanted first attr to be a nil ??
				@#{attr_name}_history << attr_name
			end 
		end
		}
  end
end

#given test code
class Foo
	#metaprogramming 
    attr_accessor_with_history :bar
end

f = Foo.new     # => #<Foo:0x127e678>
puts f.bar = 3       # => 3
puts f.bar = :wowzo  # => :wowzo
puts f.bar = 'boo!'  # => 'boo!'
puts f.bar_history   # => [nil, 3, :wowzo, 'boo!']


