module fourBitALU (input Clock, input Reset,input[3:0]A,input[3:0]B,input[2:0]OPcode,
	output reg[3:0]C,output reg ZF, output reg CF, output reg SF);

reg[1:0]temp;
reg car;

initial car = 0;
reg [2:0] count;

initial temp = 0;
initial count = 0;

parameter [2:0] RESET = 3'b000, XOR = 3'b001, ADD = 3'b010, XNOR = 3'b011, SUB = 3'b100;

always @(posedge Clock)
	begin
	if (Reset == 0)
		begin
		temp = 0;
		count = 1;
		end
	else
		begin
		if (OPcode == RESET)
			begin
			temp = 0;
			count = 1;
			C = 0;
			ZF = 0;
			SF = 0;
			CF = 0;
			car = 0;
			end
			
		else if (OPcode == XOR)
			begin
			if (count == 1)
				begin
				C[0] = A[0] ^ B[0];
				count = 2;
				end
			else if (count == 2)
				begin
				C[1] = A[1] ^ B[1];
				count = 3;
				end
			else if (count == 3)
				begin
				C[2] = A[2] ^ B[2];
				count = 4;
				end
			else if (count == 4)
				begin
				C[3] = A[3]^B[3];
				if (C == 0)
					ZF = 1;
				else
					ZF = 0;
					SF = C[3];
				
				end
			
			end
			
		else if (OPcode == SUB)
			begin
			if (count == 1)
				begin
				temp = A[0] - B[0];
				C[0] = temp[0];
				car = temp[1];
				count = 2;
				end
			else if (count == 2)
				begin
				temp = A[1] - B[1] - car;
				C[1] = temp[0];
				car = temp[1];
				count = 3;
				end
			else if (count == 3)
				begin
				temp = A[2] - B[2] - car;
				C[2] = temp[0];
				car = temp[1];
				count = 4;
				end
			else if (count==4)
				begin
				temp = A[3] - B[3] - car;
				C[3] = temp[0];
				car = temp[1];
				if (C == 0)
					ZF = 1;
				else
					ZF = 0;
					SF = C[3];
					CF = car;
				
				end
			
				
			end
		else if (OPcode == XNOR)
			begin
			if (count == 1)
				begin
				C[0] = A[0] ~^ B[0];
				count = 2;
				end
			else if (count == 2)
				begin
				C[1] = A[1] ~^ B[1];
				count = 3;
				end
			else if (count == 3)
				begin
				C[2] = A[2] ~^ B[2];
				count = 4;
				end
			else if (count == 4)
				begin
				C[3] = A[3]~^B[3];
				if (C == 0)
					ZF = 1;
				else
					ZF = 0;
					SF = C[3];
				
				end
			
			end
		else if (OPcode == ADD)
			begin
			if (count == 1)
				begin
				temp = A[0] + B[0];
				C[0] = temp[0];
				car = temp[1];
				count = 2;
				end
			else if (count == 2)
				begin
				temp = A[1] + B[1] + car;
				C[1] = temp[0];
				car = temp[1];
				count = 3;
				end
			else if (count == 3)
				begin
				temp = A[2] + B[2] + car;
				C[2] = temp[0];
				car = temp[1];
				count = 4;
				end
			else if (count == 4)
				begin
				temp = A[3] + B[3] + car;
				C[3] = temp[0];
				car = temp[1];
				if (C == 0)
					ZF = 1;
				else
					ZF = 0;
					SF = C[3];
					CF = car;
				end
			end
		end
	end
endmodule