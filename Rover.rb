class Rover

	def initialize(xAxis,yAxis)
      @xAxis = Array(1..xAxis)
      @yAxis = Array(1..yAxis)
    end

    def location(horizontalPoint, verticalPoint, cardinalPoint, movements)
      # puts "xPos #{@xAxis}"
      # puts "yPos #{@yAxis}"
      # puts "movements #{movements}"
      
      @horizontalPosition = @xAxis[horizontalPoint.to_i - 1]
      @verticalPosition = @yAxis[verticalPoint.to_i - 1]

      @directionFacing = cardinalPoint.upcase

      if(@horizontalPosition.nil? || @verticalPosition.nil?)
			puts "Coordinates must be greater than 0"
			return
	  end

	  movements.each do |m| 
      	
      	m = m.upcase
      	if(m == 'M')
      		@horizontalPosition, @verticalPosition = move(@horizontalPosition, @verticalPosition, @directionFacing)
      	else
      		@directionFacing = rotate(@directionFacing, m)
      	end
      end
      puts "Rover Position: #{@horizontalPosition} #{@verticalPosition} #{@directionFacing}"
    end

 	def rotate(cardinal, movement)

		case cardinal
		when 'E'
		  if(movement == 'R')
    	   facing = "S"
    	  else
    	   facing = "N"
    	  end
		when 'N'
    	  if(movement == 'R')
    	   facing = "E"
    	  else
    	   facing = "W"
    	  end
		when 'W'
    	  if(movement == 'R')
    	   facing = "N"
    	  else
    	   facing = "S"
    	  end
		when 'S'
    	  if(movement == 'R')
    	   facing = "W"
    	  else
    	   facing = "E"
    	  end
		else
    	  facing = "Not Found"
		end
		return facing
	end

	def move(xPosition, yPosition, direction)
		direction = direction.upcase      
		case direction
		when 'E'
    	  xPosition += 1
		when 'N'
    	  yPosition += 1
		when 'W'
    	  xPosition -= 1
		when 'S'
    	  yPosition -= 1
		else
		  xPosition, yPosition = "Not Found"
		end
		return xPosition, yPosition
	end

end

text = IO.readlines("rover_commands.txt")

xCoordinate = text[0][0].to_i
yCoordinate = text[0][2].to_i

hAxis = text[1][0].to_i
vAxis = text[1][2].to_i
direction = text[1][4].to_s



movements = text[2].scan /\w/
puts "x is #{xCoordinate}, y is #{yCoordinate}"
puts "h is #{hAxis}, v is #{vAxis}, d is #{direction} "
puts "movements are #{movements} "
rover = Rover.new(xCoordinate, yCoordinate)
rover.location(hAxis, vAxis, direction, movements)


