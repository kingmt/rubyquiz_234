require_relative 'circle_rand'
include Math

class GenerateSvg

  radius = 500
  height_width = radius * 2.2
  center = radius * 1.1

  File.open 'circle_distribution.html','w' do |file|
    # svg header
    file.puts "<!DOCTYPE html>\n<html>\n<body>"
    file.puts "<svg height='#{height_width}' width='#{height_width}'>"
    # draw circle
    file.puts "<circle cx='#{center}' cy='#{center}' r='#{radius}' stroke='black'/>"
    # draw dots
    1000.times do |count|
      distance, radian_angle = CircleRand.random_point radius
      # convert radial to grid
      grid_point = [cos(radian_angle) * distance + center,
                    sin(radian_angle) * distance + center
                   ]
      file.puts "<circle cx='#{grid_point[0]}' cy='#{grid_point[1]}' r='5' stroke='red' fill='red'/>"
    end
    # svg footer
    file.puts "</svg>\n</body>\n</html>"
  end
end
