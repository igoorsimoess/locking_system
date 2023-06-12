module LockingSystem (
  input wire clk,             
  input wire reset,           
  input wire [3:0] currentPwd,
  input wire [3:0] newPwd,
  output wire greenLed,
  output wire redLed,
  output wire [3:0] ssd
);
  reg [3:0] password;
  localparam [3:0] defaultPwd = 4'b0000;
  
  reg [2:0] attemptCount;
  localparam [2:0] maxAttempts = 3;
  
  reg [4:0] lockTimer;
  localparam [4:0] lockDuration = 30;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      password <= defaultPwd;
      attemptCount <= maxAttempts;
      lockTimer <= 0;
    end else begin
      if (currentPwd == password) begin
        greenLed <= 1'b1;
        redLed <= 1'b0;
        ssd <= 4'b1111;
        
        // Check if the new password is valid (optional)
        // Implement any validation checks for the new password here
        
        password <= newPwd;   // Update the password with the new password
      end else begin
        greenLed <= 1'b0;
        
        if (attemptCount != 0) begin
          redLed <= 1'b1;
          ssd <= attemptCount;
          attemptCount <= attemptCount - 1;
        end else begin
          if (lockTimer != 0) begin
            redLed <= 1'b1;
            ssd <= lockTimer;
            lockTimer <= lockTimer - 1;
          end else begin
            redLed <= 1'b0;
          end
        end
      end
    end
  end
  
  // Add your code here
  
endmodule
