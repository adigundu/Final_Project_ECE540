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
					
	parameter 	map1 = 4'b0001,
				map2 = 4'b0010,
				map3 = 4'b0100,
				map4 = 4'b1000;
				
	reg [3:0] state, next_state;
	
	// State: one of four maps enabled
	
	// State register
	always @( posedge clk or posedge reset ) begin
		if ( reset )
			state = 0;
		else
			state = next_state;
	end
	
	// State output logic
	always @( state ) begin
		case( state )
			map1:
				map_en = map1;
			map2:
				map_en = map2;
			map3:
				map_en = map3;
			map4:
				map_en = map4;
			default:
				map_en = map1;
		endcase 
	end
	
	// Next state generation decode logic on select change.
	always @( state or map_change ) begin
		if( map_select) begin
            case ( map_select )
            0: 
                next_state = map1;
            1:
                next_state = map2;
            2:
                next_state = map3;
            3:
                next_state = map4;
            default:
                next_state = map1;
            endcase
        end
        else begin
            if(state == map4) next_state = map1;
            else next_state = state << 1;
        end
	end
		
			
	endmodule
			