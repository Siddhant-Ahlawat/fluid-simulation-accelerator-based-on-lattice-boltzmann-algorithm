



module collide(
input  wire signed [26:0] n0_in,
input  wire signed [26:0] ns_in,
input  wire signed [26:0] nn_in,
input  wire signed [26:0] nw_in,
input  wire signed [26:0] ne_in,
input  wire signed [26:0] nnw_in,
input  wire signed [26:0] nne_in,
input  wire signed [26:0] nsw_in,
input  wire signed [26:0] nse_in,
input  wire signed [26:0] omega,
input  wire signed [26:0] one9th,
input  wire signed [26:0] one36th,
output wire signed [26:0] n0_out,
output wire signed [26:0] ns_out,
output wire signed [26:0] nn_out,
output wire signed [26:0] nw_out,
output wire signed [26:0] ne_out,
output wire signed [26:0] nnw_out,
output wire signed [26:0] nne_out,
output wire signed [26:0] nsw_out,
output wire signed [26:0] nse_out,
output wire signed [26:0] ux,
output wire signed [26:0] uy 
);




wire signed [26:0] onefix;

wire signed [26:0] this_rho;
wire signed [26:0] rho_inv;

wire signed [26:0] thisux;
wire signed [26:0] thisuy; 

wire signed [26:0] one9thrho;
wire signed [26:0] one36thrho;

wire signed [26:0] ux3;
wire signed [26:0] uy3;
wire signed [26:0] ux2;
wire signed [26:0] uy2;
wire signed [26:0] uxuy2;
wire signed [26:0] u2;
wire signed [26:0] u215;

assign onefix= 27'sd1<<<25;

assign ux = thisux;
assign uy = thisuy;


assign this_rho = n0_in + nn_in +ns_in + nw_in + ne_in + nnw_in + nne_in +nsw_in + nse_in ;

wire signed [26:0] temp1;
signed_mult s1(temp1,(this_rho - onefix),(this_rho - onefix));

assign rho_inv = onefix - (this_rho - onefix) + temp1;

wire signed [26:0] temp2;
signed_mult s2(temp2,(rho_inv),(ne_in + nne_in + nse_in - nw_in -nnw_in -nsw_in));

assign thisux=temp2;


wire signed [26:0] temp3;
signed_mult s3(temp3,(rho_inv),(nn_in + nne_in + nnw_in - ns_in -nse_in -nsw_in));

assign thisuy = temp3;


signed_mult s4(one9thrho, this_rho, one9th);
signed_mult s5(one36thrho, this_rho, one36th);


m3 k0(thisux,ux3);
m3 k1(thisuy,uy3);
signed_mult s6 (ux2,thisux,thisux);
signed_mult s7 (uy2,thisuy,thisuy);
wire signed [26:0] temp4;
signed_mult s8 (temp4,thisux,thisuy);
assign uxuy2 = temp4<<<1;

assign u2 =ux2 + uy2;
m1_5 p0(u2,u215);



wire signed [26:0] m45ux2;
wire signed [26:0] m45uy2;

m4_5 r0(ux2,m45ux2);
m4_5 r1(uy2,m45uy2);



wire signed [26:0] netemp1;
wire signed [26:0] netemp2;

signed_mult pp1(netemp1,one9thrho, (onefix + ux3    + m45ux2   - u215));
signed_mult pp2(netemp2,omega,(netemp1 - ne_in));


assign ne_out = ne_in + netemp2;


wire signed [26:0] nwtemp1;
wire signed [26:0] nwtemp2;

signed_mult pw1(nwtemp1,one9thrho, (onefix - ux3    + m45ux2   - u215));
signed_mult pw2(nwtemp2,omega,(nwtemp1 - nw_in));


assign nw_out = nw_in + nwtemp2;
 
 
wire signed [26:0] nntemp1;
wire signed [26:0] nntemp2;

signed_mult pn1(nntemp1,one9thrho, (onefix + uy3    + m45uy2   - u215));
signed_mult pn2(nntemp2,omega,(nntemp1 - nn_in));


assign nn_out = nn_in + nntemp2;

wire signed [26:0] nstemp1;
wire signed [26:0] nstemp2;

signed_mult ps1(nstemp1,one9thrho, (onefix - uy3    + m45uy2   - u215));
signed_mult ps2(nstemp2,omega,(nstemp1 - ns_in));


assign ns_out = ns_in + nstemp2;

wire signed [26:0] nnetemp1;
wire signed [26:0] nnetemp2;
wire signed [26:0] nnetemp3;

m4_5 g1((u2+uxuy2),nnetemp3);

signed_mult psr1(nnetemp1,one36thrho, (onefix + uy3 +ux3    + nnetemp3   - u215));
signed_mult psr2(nnetemp2,omega,(nnetemp1 - nne_in));


assign nne_out = nne_in + nnetemp2;

wire signed [26:0] nsetemp1;
wire signed [26:0] nsetemp2;
wire signed [26:0] nsetemp3;

m4_5 g11((u2 - uxuy2),nsetemp3);

signed_mult psrr1(nsetemp1,one36thrho, (onefix - uy3 +ux3    + nsetemp3   - u215));
signed_mult psrr2(nsetemp2,omega,(nsetemp1 - nse_in));


assign nse_out = nse_in + nsetemp2;

wire signed [26:0] nnwtemp1;
wire signed [26:0] nnwtemp2;
wire signed [26:0] nnwtemp3;

m4_5 g12((u2 - uxuy2),nnwtemp3);

signed_mult psw1(nnwtemp1,one36thrho, (onefix + uy3 - ux3    + nnwtemp3   - u215));
signed_mult psw2(nnwtemp2,omega,(nnwtemp1 - nnw_in));


assign nnw_out = nnw_in + nnwtemp2;

wire signed [26:0] nswtemp1;
wire signed [26:0] nswtemp2;
wire signed [26:0] nswtemp3;

m4_5 g13((u2 + uxuy2),nswtemp3);

signed_mult psj1(nswtemp1,one36thrho, (onefix - uy3 - ux3    + nswtemp3   - u215));
signed_mult psj2(nswtemp2,omega,(nswtemp1 - nsw_in));


assign nsw_out = nsw_in + nswtemp2;


assign n0_out = this_rho - (nn_out +ne_out +nw_out +nsw_out + ns_out + nse_out +nne_out +nnw_out);




endmodule



//////////////////////////////////////////////////
//// signed mult of 2.25 format 2'comp////////////
//////////////////////////////////////////////////

module signed_mult (out, a, b);
	output 	signed  [26:0]	out;
	input 	signed	[26:0] 	a;
	input 	signed	[26:0] 	b;
	// intermediate full bit length
	wire 	signed	[53:0]	mult_out;
	assign mult_out = a * b;
	// select bits
	assign out = {mult_out[53], mult_out[51:25]};
endmodule
//////////////////////////////////////////////////




module m3 (input wire signed [26:0] a,
output wire signed [26:0] out);


assign out = a + (a<<<1);



endmodule

module m4_5 (input wire signed  [26:0] a,
output wire signed [26:0] out);


assign out = (a<<<2) + (a>>>1);



endmodule


module m1_5 (input wire signed  [26:0] a,
output wire signed [26:0] out);


assign out = (a) + (a>>>1);



endmodule





module tb_lb();

 wire signed [26:0] n0_out;
 wire signed [26:0] ns_out;
 wire signed [26:0] nn_out;
 wire signed [26:0] nw_out;
 wire signed [26:0] ne_out;
 wire signed [26:0] nnw_out;
 wire signed [26:0] nne_out;
 wire signed [26:0] nsw_out;
 wire signed [26:0] nse_out;
 wire signed [26:0] ux;
 wire signed [26:0] uy; 
  


collide c0(.n0_in(27'd14913084),
.ns_in(27'd3728270),
.nn_in(27'd3728270),
.nw_in(27'd3728270),
.ne_in(27'd3716727),
.nnw_in(27'd932067),
.nne_in(27'd943193),
.nsw_in(27'd932067),
.nse_in(27'd929210),
.omega(27'd65922266),
.one9th(27'd3728270),
.one36th(27'd932067),
.n0_out(n0_out),
.ns_out(ns_out),
.nn_out(nn_out),
.nw_out(nw_out),
.ne_out(ne_out),
.nnw_out(nnw_out),
.nne_out(nne_out),
.nsw_out(nsw_out),
.nse_out(nse_out),
.ux(ux),
.uy(uy) );



endmodule