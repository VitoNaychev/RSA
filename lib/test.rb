str = "1, 2, 3, 4"

str.split(", ").each do |num|
    num = num.to_i
    print num + " "
end

#print arr[0].to_s + arr[1].to_s
