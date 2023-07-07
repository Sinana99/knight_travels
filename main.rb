
class Knight

    @@moves = [[1,2], [-1,2], [1,-2],[-1,-2], [-2,1], [2,-1], [-2,-1] ,[2,1]]
    @@board = Array.new(8) { Array.new(8) { |index| index +1} }

    
    attr_accessor :root, :moves, :children, :board
    
    def initialize(root)
        x = root[0]
        y = root[1]
        @root = [x,y]
        @children = []
        @@board[x][y] = "x"
    end

    def self.moves
        @@moves
    end

    def self.board
        @@board
    end

    def play(ending, position = self, queue = [])
        
        
        @@moves.each do |move|
            x = position.root[0] + move[0]
            y = position.root[1] + move[1]
            
            if x >= 0 && x <= 7 && y >= 0 && y <= 7 && @@board[x][y] != "x"
                position.children.append(Knight.new([x,y]))
                if [x,y] == ending
                   result(position.children[-1], ending)
                   
                   exit
                end
            end
        end
        
        position.children.each do |nexto|
            queue.append(nexto)
        end
       play(ending, queue[0], queue[1..])

    end

    def result(position, ending)
        array = []
        array.append(position.root)
        while array[-1] != self.root do
        position = get_parent(position)
        array.append(position.root)
        end

        output(array.reverse)
        
    end

    def get_parent(position, node =self, queue = [])
        return node if node == position

        node.children.each do |child|
            queue.append(child)
            if child.root == position.root   
                return node
            end
        end
            node = get_parent(position, queue[0], queue[1..])
        
        return node
        
    end

    def output(array)
        puts "You made it in #{array.length-1} moves! Here's your path:"
        array.each {|n| puts "[#{n[0]+1}, #{n[1]+1}]"}
    end
end


def knight_moves(start, ending)

    if start == ending
        p "You are already at the ending point, try other coordinates"
    elsif start.any? {|num| num <= 0} || start.any? {|num| num > 8} || ending.any? {|num| num <= 0} || ending.any? {|num| num > 8}
        p "Enter coordinates between 1 and 8"

    else

    knight = Knight.new([start[0]-1, start[1]-1])

    knight.play([ending[0]-1, ending[1]-1])
    end
end


knight_moves([8, 8], [4,1])
