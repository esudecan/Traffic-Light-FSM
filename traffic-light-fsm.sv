module Traffic
(
    input  logic clk,      
    input  logic reset,    
    input  logic TAORB,    
    output logic LA_green, // Street A Green 
    output logic LA_yellow,// Street A Yellow 
    output logic LA_red,   // Street A Red 
    output logic LB_green, // Street B Green 
    output logic LB_yellow,// Street B Yellow 
    output logic LB_red    // Street B Red 
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // LA: Green,  LB: Red
        S1 = 2'b01, // LA: Yellow, LB: Red
        S2 = 2'b10, // LA: Red,    LB: Green
        S3 = 2'b11  // LA: Red,    LB: Yellow
    } state_t;

    state_t state, next_state;
    logic [2:0] timer; 

    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end


    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            timer <= 0;
        else if ((state == S1 || state == S3) && (state == next_state))
            timer <= timer + 1;
        else
            timer <= 0; 
    end

 
    always_comb
    begin
        next_state = state; 

        case (state)
            S0: begin
                if (~TAORB) next_state = S1; 
            end
            S1: begin
                if (timer >= 5) next_state = S2; 
            end
            S2: begin
                if (TAORB) next_state = S3; 
            end
            S3: begin
                if (timer >= 5) next_state = S0; 
			   end
            default: next_state = S0;
				
        endcase
    end

    always_comb
    begin
     
        LA_green = 0; LA_yellow = 0; LA_red = 1;
        LB_green = 0; LB_yellow = 0; LB_red = 1;

        case (state)
            S0: begin LA_green = 1; LA_red = 0; LB_red = 1; end // A: Green, B: Red
            S1: begin LA_yellow = 1; LA_red = 0; LB_red = 1; end // A: Yellow, B: Red 
            S2: begin LA_red = 1; LB_green = 1; LB_red = 0; end // A: Red, B: Green 
            S3: begin LA_red = 1; LB_yellow = 1; LB_red = 0; end // A: Red, B: Yellow 
        endcase
    end

endmodule