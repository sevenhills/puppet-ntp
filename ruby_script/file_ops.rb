begin  
  File.open('sample.txt', 'r') do |f1|  
    count = 1
    while line = f1.gets  
      words = line.strip.split(/\s+/)  
      if count == 3
         puts words[3]
         break
      end
      count += 1
    end  
  end  
rescue Exception => msg  
  # display the system generated error message  
  puts msg  
end  
