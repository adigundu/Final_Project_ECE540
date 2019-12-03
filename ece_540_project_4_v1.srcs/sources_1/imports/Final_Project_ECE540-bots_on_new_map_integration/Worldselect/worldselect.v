//
//	ECE 540 Final Project
//	Michael Escue
//	worldselect.v
//	11/25/19
//



module worldselect(	input wire clk,
                    input wire reset, 
					input wire map_change, 
					input wire [1:0] map_select, 
					output reg [3:0] map_en );
					
	parameter 	map1_out = 4'b0001,
				map2_out = 4'b0010,
				map3_out = 4'b0100,
				map4_out = 4'b1000,
				map1 = 0,
				map2 = 1, 
				map3 = 2,
				map4 = 3;
	
	// Synchronous elements
	reg [1:0]state, next_state, prev_map_select;
	
	// Asynchronous elements.
	wire rseqchange, seqchange;
	
	assign seqchange = (prev_map_select == map_select);	
	assign rseqchange = (prev_map_select != map_select);
	
    // Output Logic
    always@(state) begin
        case(state)
            map1:   begin
                         map_en <= map1_out;
                         prev_map_select <= map_select;
                    end
            map2:   begin
                         map_en <= map2_out;
                         prev_map_select <= map_select;
                    end
            map3:   begin
                        map_en <= map3_out;
                        prev_map_select <= map_select;
                    end
            map4:   begin
                        map_en <= map4_out;
                        prev_map_select <= map_select;
                    end
           default: begin
                         map_en <= map1_out;
                         prev_map_select <= map_select;
                    end
        endcase
    end
        
    // Next State Logic
    always@( state or  map_change) begin
        if(map_change == 1'b1) begin
            if(rseqchange == 1'b1)
                next_state <= map_select;
            else if(seqchange == 1'b1) begin
                if(state == 3)
                    next_state <= 0;
                else begin
                    next_state <= state +1;
                end 
            end
            else next_state <= map1;
         end
         else next_state <= next_state;
    end 
    
    
    // State Synchronization
    always@(posedge clk or posedge reset) begin
        if(reset == 1'b1) begin
            state <= map1;
        end
        else 
            state <= next_state;
    end
            
            
            
	endmodule
			