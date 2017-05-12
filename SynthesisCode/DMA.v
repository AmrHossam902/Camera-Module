//
// Verilog description for cell DMA, 
// Fri May 12 09:21:46 2017
//
// LeonardoSpectrum Level 3, 2016a.6 
//


module DMA ( clk, rst, start_DMA, Data_in, NVM_addr_in, write_signal, Ack, 
             Data_out, cache_addr, NVM_addr_out ) ;

    input clk ;
    input rst ;
    input start_DMA ;
    input [127:0]Data_in ;
    input [11:0]NVM_addr_in ;
    output write_signal ;
    output Ack ;
    output [7:0]Data_out ;
    output [7:0]cache_addr ;
    output [11:0]NVM_addr_out ;

    wire cache_adder_out_7, cache_adder_out_6, cache_adder_out_5, 
         cache_adder_out_4, cache_adder_out_3, cache_adder_out_2, 
         cache_adder_out_1, cache_adder_out_0, NVM_adder_out_11, 
         NVM_adder_out_10, NVM_adder_out_9, NVM_adder_out_8, NVM_adder_out_7, 
         NVM_adder_out_6, NVM_adder_out_5, NVM_adder_out_4, 
         NVM_address_Mux_out_11, NVM_address_Mux_out_10, NVM_address_Mux_out_9, 
         NVM_address_Mux_out_8, NVM_address_Mux_out_7, NVM_address_Mux_out_6, 
         NVM_address_Mux_out_5, NVM_address_Mux_out_4, NVM_address_Mux_out_3, 
         NVM_address_Mux_out_2, NVM_address_Mux_out_1, NVM_address_Mux_out_0, 
         row_done, rows_done, signals_4, signals_3, signals_1, PWR, GND, nx192, 
         nx194;
    wire [4:0] \$dummy ;




    DMACU controlUnit (.clk (clk), .reset (rst), .start_DMA (start_DMA), .Rows_Done (
          rows_done), .Row_Done (row_done), .signals ({write_signal,signals_4,
          signals_3,\$dummy [0],signals_1,Ack})) ;
    nbit_Register_8 R_Cache_addr (.Clk (clk), .rst (nx192), .enable (
                    write_signal), .d ({cache_adder_out_7,cache_adder_out_6,
                    cache_adder_out_5,cache_adder_out_4,cache_adder_out_3,
                    cache_adder_out_2,cache_adder_out_1,cache_adder_out_0}), .rst_value (
                    {GND,GND,GND,GND,GND,GND,GND,GND}), .q ({cache_addr[7],
                    cache_addr[6],cache_addr[5],cache_addr[4],cache_addr[3],
                    cache_addr[2],cache_addr[1],cache_addr[0]})) ;
    nbit_Register_12 R_NVM_addr (.Clk (clk), .rst (nx194), .enable (signals_3), 
                     .d ({NVM_address_Mux_out_11,NVM_address_Mux_out_10,
                     NVM_address_Mux_out_9,NVM_address_Mux_out_8,
                     NVM_address_Mux_out_7,NVM_address_Mux_out_6,
                     NVM_address_Mux_out_5,NVM_address_Mux_out_4,
                     NVM_address_Mux_out_3,NVM_address_Mux_out_2,
                     NVM_address_Mux_out_1,NVM_address_Mux_out_0}), .rst_value (
                     {GND,GND,GND,GND,GND,GND,GND,GND,GND,GND,GND,GND}), .q ({
                     NVM_addr_out[11],NVM_addr_out[10],NVM_addr_out[9],
                     NVM_addr_out[8],NVM_addr_out[7],NVM_addr_out[6],
                     NVM_addr_out[5],NVM_addr_out[4],NVM_addr_out[3],
                     NVM_addr_out[2],NVM_addr_out[1],NVM_addr_out[0]})) ;
    nbit_adder_8 u1 (.a ({cache_addr[7],cache_addr[6],cache_addr[5],
                 cache_addr[4],cache_addr[3],cache_addr[2],cache_addr[1],
                 cache_addr[0]}), .b ({GND,GND,GND,GND,GND,GND,GND,GND}), .cin (
                 PWR), .add_out ({cache_adder_out_7,cache_adder_out_6,
                 cache_adder_out_5,cache_adder_out_4,cache_adder_out_3,
                 cache_adder_out_2,cache_adder_out_1,cache_adder_out_0})) ;
    nbit_adder_12 u2 (.a ({NVM_addr_out[11],NVM_addr_out[10],NVM_addr_out[9],
                  NVM_addr_out[8],NVM_addr_out[7],NVM_addr_out[6],
                  NVM_addr_out[5],NVM_addr_out[4],GND,GND,GND,GND}), .b ({GND,
                  GND,GND,GND,GND,GND,GND,PWR,GND,GND,GND,GND}), .cin (GND), .add_out (
                  {NVM_adder_out_11,NVM_adder_out_10,NVM_adder_out_9,
                  NVM_adder_out_8,NVM_adder_out_7,NVM_adder_out_6,
                  NVM_adder_out_5,NVM_adder_out_4,\$dummy [1],\$dummy [2],
                  \$dummy [3],\$dummy [4]})) ;
    mux16x1 u3 (.x0 ({Data_in[127],Data_in[126],Data_in[125],Data_in[124],
            Data_in[123],Data_in[122],Data_in[121],Data_in[120]}), .x1 ({
            Data_in[119],Data_in[118],Data_in[117],Data_in[116],Data_in[115],
            Data_in[114],Data_in[113],Data_in[112]}), .x2 ({Data_in[111],
            Data_in[110],Data_in[109],Data_in[108],Data_in[107],Data_in[106],
            Data_in[105],Data_in[104]}), .x3 ({Data_in[103],Data_in[102],
            Data_in[101],Data_in[100],Data_in[99],Data_in[98],Data_in[97],
            Data_in[96]}), .x4 ({Data_in[95],Data_in[94],Data_in[93],Data_in[92]
            ,Data_in[91],Data_in[90],Data_in[89],Data_in[88]}), .x5 ({
            Data_in[87],Data_in[86],Data_in[85],Data_in[84],Data_in[83],
            Data_in[82],Data_in[81],Data_in[80]}), .x6 ({Data_in[79],Data_in[78]
            ,Data_in[77],Data_in[76],Data_in[75],Data_in[74],Data_in[73],
            Data_in[72]}), .x7 ({Data_in[71],Data_in[70],Data_in[69],Data_in[68]
            ,Data_in[67],Data_in[66],Data_in[65],Data_in[64]}), .x8 ({
            Data_in[63],Data_in[62],Data_in[61],Data_in[60],Data_in[59],
            Data_in[58],Data_in[57],Data_in[56]}), .x9 ({Data_in[55],Data_in[54]
            ,Data_in[53],Data_in[52],Data_in[51],Data_in[50],Data_in[49],
            Data_in[48]}), .x10 ({Data_in[47],Data_in[46],Data_in[45],
            Data_in[44],Data_in[43],Data_in[42],Data_in[41],Data_in[40]}), .x11 (
            {Data_in[39],Data_in[38],Data_in[37],Data_in[36],Data_in[35],
            Data_in[34],Data_in[33],Data_in[32]}), .x12 ({Data_in[31],
            Data_in[30],Data_in[29],Data_in[28],Data_in[27],Data_in[26],
            Data_in[25],Data_in[24]}), .x13 ({Data_in[23],Data_in[22],
            Data_in[21],Data_in[20],Data_in[19],Data_in[18],Data_in[17],
            Data_in[16]}), .x14 ({Data_in[15],Data_in[14],Data_in[13],
            Data_in[12],Data_in[11],Data_in[10],Data_in[9],Data_in[8]}), .x15 ({
            Data_in[7],Data_in[6],Data_in[5],Data_in[4],Data_in[3],Data_in[2],
            Data_in[1],Data_in[0]}), .sel ({cache_addr[3],cache_addr[2],
            cache_addr[1],cache_addr[0]}), .y ({Data_out[7],Data_out[6],
            Data_out[5],Data_out[4],Data_out[3],Data_out[2],Data_out[1],
            Data_out[0]})) ;
    nbit_mux2x1_12 u4 (.input1 ({NVM_adder_out_11,NVM_adder_out_10,
                   NVM_adder_out_9,NVM_adder_out_8,NVM_adder_out_7,
                   NVM_adder_out_6,NVM_adder_out_5,NVM_adder_out_4,
                   NVM_addr_out[3],NVM_addr_out[2],NVM_addr_out[1],
                   NVM_addr_out[0]}), .input2 ({NVM_addr_in[11],NVM_addr_in[10],
                   NVM_addr_in[9],NVM_addr_in[8],NVM_addr_in[7],NVM_addr_in[6],
                   NVM_addr_in[5],NVM_addr_in[4],NVM_addr_in[3],NVM_addr_in[2],
                   NVM_addr_in[1],NVM_addr_in[0]}), .s0 (signals_4), .\output  (
                   {NVM_address_Mux_out_11,NVM_address_Mux_out_10,
                   NVM_address_Mux_out_9,NVM_address_Mux_out_8,
                   NVM_address_Mux_out_7,NVM_address_Mux_out_6,
                   NVM_address_Mux_out_5,NVM_address_Mux_out_4,
                   NVM_address_Mux_out_3,NVM_address_Mux_out_2,
                   NVM_address_Mux_out_1,NVM_address_Mux_out_0})) ;
   
    and04 ix5 (.Y (rows_done), .A0 (cache_addr[7]), .A1 (cache_addr[6]), .A2 (
          cache_addr[5]), .A3 (cache_addr[4])) ;
    and04 ix11 (.Y (row_done), .A0 (cache_addr[3]), .A1 (cache_addr[2]), .A2 (
          cache_addr[1]), .A3 (cache_addr[0])) ;
    buf02 ix191 (.Y (nx192), .A (signals_1)) ;
    buf02 ix193 (.Y (nx194), .A (signals_1)) ;
endmodule


module nbit_mux2x1_12 ( input1, input2, s0, \output  ) ;

    input [11:0]input1 ;
    input [11:0]input2 ;
    input s0 ;
    output [11:0]\output  ;

    wire nx157, nx159;



    mux21_ni ix7 (.Y (\output [0]), .A0 (input1[0]), .A1 (input2[0]), .S0 (nx157
             )) ;
    mux21_ni ix15 (.Y (\output [1]), .A0 (input1[1]), .A1 (input2[1]), .S0 (
             nx157)) ;
    mux21_ni ix23 (.Y (\output [2]), .A0 (input1[2]), .A1 (input2[2]), .S0 (
             nx157)) ;
    mux21_ni ix31 (.Y (\output [3]), .A0 (input1[3]), .A1 (input2[3]), .S0 (
             nx157)) ;
    mux21_ni ix39 (.Y (\output [4]), .A0 (input1[4]), .A1 (input2[4]), .S0 (
             nx157)) ;
    mux21_ni ix47 (.Y (\output [5]), .A0 (input1[5]), .A1 (input2[5]), .S0 (
             nx157)) ;
    mux21_ni ix55 (.Y (\output [6]), .A0 (input1[6]), .A1 (input2[6]), .S0 (
             nx159)) ;
    mux21_ni ix63 (.Y (\output [7]), .A0 (input1[7]), .A1 (input2[7]), .S0 (
             nx159)) ;
    mux21_ni ix71 (.Y (\output [8]), .A0 (input1[8]), .A1 (input2[8]), .S0 (
             nx159)) ;
    mux21_ni ix79 (.Y (\output [9]), .A0 (input1[9]), .A1 (input2[9]), .S0 (
             nx159)) ;
    mux21_ni ix87 (.Y (\output [10]), .A0 (input1[10]), .A1 (input2[10]), .S0 (
             nx159)) ;
    mux21_ni ix95 (.Y (\output [11]), .A0 (input1[11]), .A1 (input2[11]), .S0 (
             nx159)) ;
    buf04 ix156 (.Y (nx157), .A (s0)) ;
    buf04 ix158 (.Y (nx159), .A (s0)) ;
endmodule


module mux16x1 ( x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, 
                 x15, sel, y ) ;

    input [7:0]x0 ;
    input [7:0]x1 ;
    input [7:0]x2 ;
    input [7:0]x3 ;
    input [7:0]x4 ;
    input [7:0]x5 ;
    input [7:0]x6 ;
    input [7:0]x7 ;
    input [7:0]x8 ;
    input [7:0]x9 ;
    input [7:0]x10 ;
    input [7:0]x11 ;
    input [7:0]x12 ;
    input [7:0]x13 ;
    input [7:0]x14 ;
    input [7:0]x15 ;
    input [3:0]sel ;
    output [7:0]y ;

    wire nx10, nx18, nx22, nx32, nx36, nx48, nx54, nx60, nx68, nx78, nx82, nx225, 
         nx92, nx100, nx104, nx110, nx114, nx130, nx192, nx254, nx316, nx378, 
         nx440, nx502, nx239, nx241, nx245, nx247, nx249, nx253, nx257, nx259, 
         nx263, nx265, nx267, nx271, nx275, nx279, nx281, nx285, nx291, nx297, 
         nx311, nx313, nx315, nx317, nx319, nx321, nx323, nx325, nx331, nx333, 
         nx335, nx337, nx339, nx341, nx343, nx345, nx351, nx353, nx355, nx357, 
         nx359, nx361, nx363, nx365, nx371, nx373, nx375, nx377, nx379, nx381, 
         nx383, nx385, nx391, nx393, nx395, nx397, nx399, nx401, nx403, nx405, 
         nx411, nx413, nx415, nx417, nx419, nx421, nx423, nx425, nx431, nx433, 
         nx435, nx437, nx439, nx441, nx443, nx445, nx454, nx456, nx458, nx460, 
         nx462, nx464, nx466, nx468, nx470, nx472, nx474, nx476, nx478, nx480, 
         nx482, nx484, nx486, nx488, nx490, nx492, nx494, nx496, nx499, nx501, 
         nx503, nx505, nx507, nx509, nx511, nx513, nx515, nx517, nx519, nx521, 
         nx523, nx525, nx527, nx529, nx531, nx533, nx535, nx537, nx539, nx541, 
         nx543, nx545, nx547, nx549, nx551, nx553, nx555, nx557, nx559, nx561, 
         nx563, nx565, nx567, nx569, nx571, nx573, nx575, nx577, nx579, nx581, 
         nx583, nx585, nx587, nx589, nx591, nx593, nx595, nx597, nx599, nx601, 
         nx603, nx605, nx607, nx609, nx611, nx613, nx615, nx617, nx619, nx621, 
         nx623, nx625, nx627, nx629, nx631, nx633, nx639, nx641, nx643, nx645, 
         nx647, nx649, nx651, nx653, nx655, nx657, nx659, nx661, nx663, nx665, 
         nx667, nx669, nx671, nx673, nx675, nx677, nx679, nx681, nx683, nx685, 
         nx687, nx689, nx691, nx693, nx695, nx697, nx699, nx701, nx703, nx705, 
         nx707, nx709, nx711, nx713, nx715, nx717, nx719, nx721, nx723, nx725, 
         nx727, nx729, nx731, nx733, nx735, nx737, nx739, nx741, nx743, nx745, 
         nx747, nx749, nx751, nx753, nx755, nx757, nx759, nx761, nx763, nx765, 
         nx767, nx769, nx771, nx773, nx775, nx777, nx779, nx781, nx783, nx785, 
         nx787, nx789, nx791, nx793, nx795, nx797, nx799, nx801, nx803, nx805, 
         nx807, nx809, nx811, nx813, nx815, nx817, nx819, nx821, nx823, nx825, 
         nx827, nx829, nx831, nx837, nx839, nx841, nx843;



    nand04_2x ix125 (.Y (y[0]), .A0 (nx239), .A1 (nx531), .A2 (nx533), .A3 (
              nx535)) ;
    and04 ix240 (.Y (nx239), .A0 (nx503), .A1 (nx513), .A2 (nx519), .A3 (nx525)
          ) ;
    aoi22 ix242 (.Y (nx241), .A0 (x7[0]), .A1 (nx496), .B0 (x4[0]), .B1 (nx499)
          ) ;
    nor02_2x ix111 (.Y (nx110), .A0 (nx505), .A1 (nx509)) ;
    nand02_2x ix246 (.Y (nx245), .A0 (nx841), .A1 (nx843)) ;
    nand02_2x ix248 (.Y (nx247), .A0 (nx249), .A1 (nx839)) ;
    inv02 ix250 (.Y (nx249), .A (sel[3])) ;
    nor03_2x ix115 (.Y (nx114), .A0 (nx841), .A1 (nx843), .A2 (nx509)) ;
    aoi22 ix254 (.Y (nx253), .A0 (x11[0]), .A1 (nx492), .B0 (x6[0]), .B1 (nx494)
          ) ;
    nor02_2x ix101 (.Y (nx100), .A0 (nx505), .A1 (nx515)) ;
    nand02_2x ix258 (.Y (nx257), .A0 (nx837), .A1 (nx259)) ;
    inv02 ix260 (.Y (nx259), .A (sel[2])) ;
    nor02_2x ix105 (.Y (nx104), .A0 (nx517), .A1 (nx509)) ;
    nand02_2x ix264 (.Y (nx263), .A0 (nx841), .A1 (nx265)) ;
    inv02 ix266 (.Y (nx265), .A (sel[0])) ;
    aoi22 ix268 (.Y (nx267), .A0 (x15[0]), .A1 (nx486), .B0 (x12[0]), .B1 (nx488
          )) ;
    nor02_2x ix91 (.Y (nx225), .A0 (nx521), .A1 (nx505)) ;
    nand02_2x ix272 (.Y (nx271), .A0 (nx837), .A1 (nx839)) ;
    nor03_2x ix93 (.Y (nx92), .A0 (nx521), .A1 (nx841), .A2 (nx843)) ;
    aoi22 ix276 (.Y (nx275), .A0 (x1[0]), .A1 (nx482), .B0 (x0[0]), .B1 (nx478)
          ) ;
    nor03_2x ix83 (.Y (nx82), .A0 (nx837), .A1 (nx839), .A2 (nx527)) ;
    nand02_2x ix280 (.Y (nx279), .A0 (nx281), .A1 (nx843)) ;
    inv02 ix282 (.Y (nx281), .A (sel[1])) ;
    nor04 ix79 (.Y (nx78), .A0 (nx841), .A1 (nx843), .A2 (nx837), .A3 (nx839)) ;
    aoi22 ix286 (.Y (nx285), .A0 (x14[0]), .A1 (nx474), .B0 (x5[0]), .B1 (nx476)
          ) ;
    nor02_2x ix61 (.Y (nx60), .A0 (nx521), .A1 (nx517)) ;
    nor02_2x ix69 (.Y (nx68), .A0 (nx509), .A1 (nx527)) ;
    aoi22 ix292 (.Y (nx291), .A0 (x13[0]), .A1 (nx472), .B0 (x9[0]), .B1 (nx470)
          ) ;
    nor02_2x ix55 (.Y (nx54), .A0 (nx521), .A1 (nx527)) ;
    nor02_2x ix49 (.Y (nx48), .A0 (nx515), .A1 (nx527)) ;
    aoi221 ix298 (.Y (nx297), .A0 (x2[0]), .A1 (nx466), .B0 (x3[0]), .B1 (nx462)
           , .C0 (nx22)) ;
    nor03_2x ix37 (.Y (nx36), .A0 (nx517), .A1 (nx837), .A2 (nx839)) ;
    nor03_2x ix33 (.Y (nx32), .A0 (nx505), .A1 (nx837), .A2 (nx839)) ;
    ao22 ix23 (.Y (nx22), .A0 (x10[0]), .A1 (nx458), .B0 (x8[0]), .B1 (nx454)) ;
    nor02_2x ix19 (.Y (nx18), .A0 (nx517), .A1 (nx515)) ;
    nor03_2x ix11 (.Y (nx10), .A0 (nx841), .A1 (nx843), .A2 (nx515)) ;
    nand04_2x ix187 (.Y (y[1]), .A0 (nx311), .A1 (nx545), .A2 (nx547), .A3 (
              nx549)) ;
    and04 ix312 (.Y (nx311), .A0 (nx537), .A1 (nx539), .A2 (nx541), .A3 (nx543)
          ) ;
    aoi22 ix314 (.Y (nx313), .A0 (x7[1]), .A1 (nx496), .B0 (x4[1]), .B1 (nx499)
          ) ;
    aoi22 ix316 (.Y (nx315), .A0 (x11[1]), .A1 (nx492), .B0 (x6[1]), .B1 (nx494)
          ) ;
    aoi22 ix318 (.Y (nx317), .A0 (x15[1]), .A1 (nx486), .B0 (x12[1]), .B1 (nx488
          )) ;
    aoi22 ix320 (.Y (nx319), .A0 (x1[1]), .A1 (nx482), .B0 (x0[1]), .B1 (nx478)
          ) ;
    aoi22 ix322 (.Y (nx321), .A0 (x14[1]), .A1 (nx474), .B0 (x5[1]), .B1 (nx476)
          ) ;
    aoi22 ix324 (.Y (nx323), .A0 (x13[1]), .A1 (nx472), .B0 (x9[1]), .B1 (nx470)
          ) ;
    aoi221 ix326 (.Y (nx325), .A0 (x2[1]), .A1 (nx466), .B0 (x3[1]), .B1 (nx462)
           , .C0 (nx130)) ;
    ao22 ix131 (.Y (nx130), .A0 (x10[1]), .A1 (nx458), .B0 (x8[1]), .B1 (nx454)
         ) ;
    nand04_2x ix249 (.Y (y[2]), .A0 (nx331), .A1 (nx559), .A2 (nx561), .A3 (
              nx563)) ;
    and04 ix332 (.Y (nx331), .A0 (nx551), .A1 (nx553), .A2 (nx555), .A3 (nx557)
          ) ;
    aoi22 ix334 (.Y (nx333), .A0 (x7[2]), .A1 (nx496), .B0 (x4[2]), .B1 (nx499)
          ) ;
    aoi22 ix336 (.Y (nx335), .A0 (x11[2]), .A1 (nx492), .B0 (x6[2]), .B1 (nx494)
          ) ;
    aoi22 ix338 (.Y (nx337), .A0 (x15[2]), .A1 (nx486), .B0 (x12[2]), .B1 (nx488
          )) ;
    aoi22 ix340 (.Y (nx339), .A0 (x1[2]), .A1 (nx482), .B0 (x0[2]), .B1 (nx478)
          ) ;
    aoi22 ix342 (.Y (nx341), .A0 (x14[2]), .A1 (nx474), .B0 (x5[2]), .B1 (nx476)
          ) ;
    aoi22 ix344 (.Y (nx343), .A0 (x13[2]), .A1 (nx472), .B0 (x9[2]), .B1 (nx470)
          ) ;
    aoi221 ix346 (.Y (nx345), .A0 (x2[2]), .A1 (nx466), .B0 (x3[2]), .B1 (nx462)
           , .C0 (nx192)) ;
    ao22 ix193 (.Y (nx192), .A0 (x10[2]), .A1 (nx458), .B0 (x8[2]), .B1 (nx454)
         ) ;
    nand04_2x ix311 (.Y (y[3]), .A0 (nx351), .A1 (nx573), .A2 (nx575), .A3 (
              nx577)) ;
    and04 ix352 (.Y (nx351), .A0 (nx565), .A1 (nx567), .A2 (nx569), .A3 (nx571)
          ) ;
    aoi22 ix354 (.Y (nx353), .A0 (x7[3]), .A1 (nx496), .B0 (x4[3]), .B1 (nx499)
          ) ;
    aoi22 ix356 (.Y (nx355), .A0 (x11[3]), .A1 (nx492), .B0 (x6[3]), .B1 (nx494)
          ) ;
    aoi22 ix358 (.Y (nx357), .A0 (x15[3]), .A1 (nx486), .B0 (x12[3]), .B1 (nx488
          )) ;
    aoi22 ix360 (.Y (nx359), .A0 (x1[3]), .A1 (nx482), .B0 (x0[3]), .B1 (nx478)
          ) ;
    aoi22 ix362 (.Y (nx361), .A0 (x14[3]), .A1 (nx474), .B0 (x5[3]), .B1 (nx476)
          ) ;
    aoi22 ix364 (.Y (nx363), .A0 (x13[3]), .A1 (nx472), .B0 (x9[3]), .B1 (nx470)
          ) ;
    aoi221 ix366 (.Y (nx365), .A0 (x2[3]), .A1 (nx466), .B0 (x3[3]), .B1 (nx462)
           , .C0 (nx254)) ;
    ao22 ix255 (.Y (nx254), .A0 (x10[3]), .A1 (nx458), .B0 (x8[3]), .B1 (nx454)
         ) ;
    nand04_2x ix373 (.Y (y[4]), .A0 (nx371), .A1 (nx587), .A2 (nx589), .A3 (
              nx591)) ;
    and04 ix372 (.Y (nx371), .A0 (nx579), .A1 (nx581), .A2 (nx583), .A3 (nx585)
          ) ;
    aoi22 ix374 (.Y (nx373), .A0 (x7[4]), .A1 (nx496), .B0 (x4[4]), .B1 (nx499)
          ) ;
    aoi22 ix376 (.Y (nx375), .A0 (x11[4]), .A1 (nx492), .B0 (x6[4]), .B1 (nx494)
          ) ;
    aoi22 ix378 (.Y (nx377), .A0 (x15[4]), .A1 (nx486), .B0 (x12[4]), .B1 (nx488
          )) ;
    aoi22 ix380 (.Y (nx379), .A0 (x1[4]), .A1 (nx482), .B0 (x0[4]), .B1 (nx478)
          ) ;
    aoi22 ix382 (.Y (nx381), .A0 (x14[4]), .A1 (nx474), .B0 (x5[4]), .B1 (nx476)
          ) ;
    aoi22 ix384 (.Y (nx383), .A0 (x13[4]), .A1 (nx472), .B0 (x9[4]), .B1 (nx470)
          ) ;
    aoi221 ix386 (.Y (nx385), .A0 (x2[4]), .A1 (nx468), .B0 (x3[4]), .B1 (nx464)
           , .C0 (nx316)) ;
    ao22 ix317 (.Y (nx316), .A0 (x10[4]), .A1 (nx458), .B0 (x8[4]), .B1 (nx454)
         ) ;
    nand04_2x ix435 (.Y (y[5]), .A0 (nx391), .A1 (nx601), .A2 (nx603), .A3 (
              nx605)) ;
    and04 ix392 (.Y (nx391), .A0 (nx593), .A1 (nx595), .A2 (nx597), .A3 (nx599)
          ) ;
    aoi22 ix394 (.Y (nx393), .A0 (x7[5]), .A1 (nx110), .B0 (x4[5]), .B1 (nx499)
          ) ;
    aoi22 ix396 (.Y (nx395), .A0 (x11[5]), .A1 (nx100), .B0 (x6[5]), .B1 (nx104)
          ) ;
    aoi22 ix398 (.Y (nx397), .A0 (x15[5]), .A1 (nx225), .B0 (x12[5]), .B1 (nx488
          )) ;
    aoi22 ix400 (.Y (nx399), .A0 (x1[5]), .A1 (nx482), .B0 (x0[5]), .B1 (nx478)
          ) ;
    aoi22 ix402 (.Y (nx401), .A0 (x14[5]), .A1 (nx60), .B0 (x5[5]), .B1 (nx68)
          ) ;
    aoi22 ix404 (.Y (nx403), .A0 (x13[5]), .A1 (nx54), .B0 (x9[5]), .B1 (nx48)
          ) ;
    aoi221 ix406 (.Y (nx405), .A0 (x2[5]), .A1 (nx468), .B0 (x3[5]), .B1 (nx464)
           , .C0 (nx378)) ;
    ao22 ix379 (.Y (nx378), .A0 (x10[5]), .A1 (nx458), .B0 (x8[5]), .B1 (nx454)
         ) ;
    nand04_2x ix497 (.Y (y[6]), .A0 (nx411), .A1 (nx615), .A2 (nx617), .A3 (
              nx619)) ;
    and04 ix412 (.Y (nx411), .A0 (nx607), .A1 (nx609), .A2 (nx611), .A3 (nx613)
          ) ;
    aoi22 ix414 (.Y (nx413), .A0 (x7[6]), .A1 (nx110), .B0 (x4[6]), .B1 (nx501)
          ) ;
    aoi22 ix416 (.Y (nx415), .A0 (x11[6]), .A1 (nx100), .B0 (x6[6]), .B1 (nx104)
          ) ;
    aoi22 ix418 (.Y (nx417), .A0 (x15[6]), .A1 (nx225), .B0 (x12[6]), .B1 (nx490
          )) ;
    aoi22 ix420 (.Y (nx419), .A0 (x1[6]), .A1 (nx484), .B0 (x0[6]), .B1 (nx480)
          ) ;
    aoi22 ix422 (.Y (nx421), .A0 (x14[6]), .A1 (nx60), .B0 (x5[6]), .B1 (nx68)
          ) ;
    aoi22 ix424 (.Y (nx423), .A0 (x13[6]), .A1 (nx54), .B0 (x9[6]), .B1 (nx48)
          ) ;
    aoi221 ix426 (.Y (nx425), .A0 (x2[6]), .A1 (nx468), .B0 (x3[6]), .B1 (nx464)
           , .C0 (nx440)) ;
    ao22 ix441 (.Y (nx440), .A0 (x10[6]), .A1 (nx460), .B0 (x8[6]), .B1 (nx456)
         ) ;
    nand04_2x ix559 (.Y (y[7]), .A0 (nx431), .A1 (nx629), .A2 (nx631), .A3 (
              nx633)) ;
    and04 ix432 (.Y (nx431), .A0 (nx621), .A1 (nx623), .A2 (nx625), .A3 (nx627)
          ) ;
    aoi22 ix434 (.Y (nx433), .A0 (x7[7]), .A1 (nx110), .B0 (x4[7]), .B1 (nx501)
          ) ;
    aoi22 ix436 (.Y (nx435), .A0 (x11[7]), .A1 (nx100), .B0 (x6[7]), .B1 (nx104)
          ) ;
    aoi22 ix438 (.Y (nx437), .A0 (x15[7]), .A1 (nx225), .B0 (x12[7]), .B1 (nx490
          )) ;
    aoi22 ix440 (.Y (nx439), .A0 (x1[7]), .A1 (nx484), .B0 (x0[7]), .B1 (nx480)
          ) ;
    aoi22 ix442 (.Y (nx441), .A0 (x14[7]), .A1 (nx60), .B0 (x5[7]), .B1 (nx68)
          ) ;
    aoi22 ix444 (.Y (nx443), .A0 (x13[7]), .A1 (nx54), .B0 (x9[7]), .B1 (nx48)
          ) ;
    aoi221 ix446 (.Y (nx445), .A0 (x2[7]), .A1 (nx468), .B0 (x3[7]), .B1 (nx464)
           , .C0 (nx502)) ;
    ao22 ix503 (.Y (nx502), .A0 (x10[7]), .A1 (nx460), .B0 (x8[7]), .B1 (nx456)
         ) ;
    buf02 ix453 (.Y (nx454), .A (nx10)) ;
    buf02 ix455 (.Y (nx456), .A (nx10)) ;
    buf02 ix457 (.Y (nx458), .A (nx18)) ;
    buf02 ix459 (.Y (nx460), .A (nx18)) ;
    buf02 ix461 (.Y (nx462), .A (nx32)) ;
    buf02 ix463 (.Y (nx464), .A (nx32)) ;
    buf02 ix465 (.Y (nx466), .A (nx36)) ;
    buf02 ix467 (.Y (nx468), .A (nx36)) ;
    nor02_2x ix469 (.Y (nx470), .A0 (nx515), .A1 (nx527)) ;
    nor02_2x ix471 (.Y (nx472), .A0 (nx523), .A1 (nx527)) ;
    nor02_2x ix473 (.Y (nx474), .A0 (nx523), .A1 (nx517)) ;
    nor02_2x ix475 (.Y (nx476), .A0 (nx511), .A1 (nx529)) ;
    buf02 ix477 (.Y (nx478), .A (nx639)) ;
    buf02 ix479 (.Y (nx480), .A (nx639)) ;
    buf02 ix481 (.Y (nx482), .A (nx82)) ;
    buf02 ix483 (.Y (nx484), .A (nx82)) ;
    nor02_2x ix485 (.Y (nx486), .A0 (nx523), .A1 (nx507)) ;
    buf02 ix487 (.Y (nx488), .A (nx92)) ;
    buf02 ix489 (.Y (nx490), .A (nx92)) ;
    nor02_2x ix491 (.Y (nx492), .A0 (nx507), .A1 (nx515)) ;
    nor02_2x ix493 (.Y (nx494), .A0 (nx517), .A1 (nx511)) ;
    nor02_2x ix495 (.Y (nx496), .A0 (nx507), .A1 (nx511)) ;
    buf02 ix498 (.Y (nx499), .A (nx114)) ;
    buf02 ix500 (.Y (nx501), .A (nx114)) ;
    buf02 ix502 (.Y (nx503), .A (nx643)) ;
    buf02 ix504 (.Y (nx505), .A (nx245)) ;
    buf02 ix506 (.Y (nx507), .A (nx245)) ;
    buf02 ix508 (.Y (nx509), .A (nx247)) ;
    buf02 ix510 (.Y (nx511), .A (nx247)) ;
    buf02 ix512 (.Y (nx513), .A (nx647)) ;
    buf04 ix514 (.Y (nx515), .A (nx257)) ;
    buf04 ix516 (.Y (nx517), .A (nx263)) ;
    buf02 ix518 (.Y (nx519), .A (nx651)) ;
    buf02 ix520 (.Y (nx521), .A (nx271)) ;
    buf02 ix522 (.Y (nx523), .A (nx271)) ;
    buf02 ix524 (.Y (nx525), .A (nx655)) ;
    buf04 ix526 (.Y (nx527), .A (nx279)) ;
    buf04 ix528 (.Y (nx529), .A (nx279)) ;
    buf02 ix530 (.Y (nx531), .A (nx659)) ;
    buf02 ix532 (.Y (nx533), .A (nx663)) ;
    buf02 ix534 (.Y (nx535), .A (nx297)) ;
    buf02 ix536 (.Y (nx537), .A (nx667)) ;
    buf02 ix538 (.Y (nx539), .A (nx671)) ;
    buf02 ix540 (.Y (nx541), .A (nx675)) ;
    buf02 ix542 (.Y (nx543), .A (nx679)) ;
    buf02 ix544 (.Y (nx545), .A (nx683)) ;
    buf02 ix546 (.Y (nx547), .A (nx687)) ;
    buf02 ix548 (.Y (nx549), .A (nx325)) ;
    buf02 ix550 (.Y (nx551), .A (nx691)) ;
    buf02 ix552 (.Y (nx553), .A (nx695)) ;
    buf02 ix554 (.Y (nx555), .A (nx699)) ;
    buf02 ix556 (.Y (nx557), .A (nx703)) ;
    buf02 ix558 (.Y (nx559), .A (nx707)) ;
    buf02 ix560 (.Y (nx561), .A (nx711)) ;
    buf02 ix562 (.Y (nx563), .A (nx345)) ;
    buf02 ix564 (.Y (nx565), .A (nx715)) ;
    buf02 ix566 (.Y (nx567), .A (nx719)) ;
    buf02 ix568 (.Y (nx569), .A (nx723)) ;
    buf02 ix570 (.Y (nx571), .A (nx727)) ;
    buf02 ix572 (.Y (nx573), .A (nx731)) ;
    buf02 ix574 (.Y (nx575), .A (nx735)) ;
    buf02 ix576 (.Y (nx577), .A (nx365)) ;
    buf02 ix578 (.Y (nx579), .A (nx739)) ;
    buf02 ix580 (.Y (nx581), .A (nx743)) ;
    buf02 ix582 (.Y (nx583), .A (nx747)) ;
    buf02 ix584 (.Y (nx585), .A (nx751)) ;
    buf02 ix586 (.Y (nx587), .A (nx755)) ;
    buf02 ix588 (.Y (nx589), .A (nx759)) ;
    buf02 ix590 (.Y (nx591), .A (nx385)) ;
    buf02 ix592 (.Y (nx593), .A (nx763)) ;
    buf02 ix594 (.Y (nx595), .A (nx767)) ;
    buf02 ix596 (.Y (nx597), .A (nx771)) ;
    buf02 ix598 (.Y (nx599), .A (nx775)) ;
    buf02 ix600 (.Y (nx601), .A (nx779)) ;
    buf02 ix602 (.Y (nx603), .A (nx783)) ;
    buf02 ix604 (.Y (nx605), .A (nx405)) ;
    buf02 ix606 (.Y (nx607), .A (nx787)) ;
    buf02 ix608 (.Y (nx609), .A (nx791)) ;
    buf02 ix610 (.Y (nx611), .A (nx795)) ;
    buf02 ix612 (.Y (nx613), .A (nx799)) ;
    buf02 ix614 (.Y (nx615), .A (nx803)) ;
    buf02 ix616 (.Y (nx617), .A (nx807)) ;
    buf02 ix618 (.Y (nx619), .A (nx425)) ;
    buf02 ix620 (.Y (nx621), .A (nx811)) ;
    buf02 ix622 (.Y (nx623), .A (nx815)) ;
    buf02 ix624 (.Y (nx625), .A (nx819)) ;
    buf02 ix626 (.Y (nx627), .A (nx823)) ;
    buf02 ix628 (.Y (nx629), .A (nx827)) ;
    buf02 ix630 (.Y (nx631), .A (nx831)) ;
    buf02 ix632 (.Y (nx633), .A (nx445)) ;
    buf02 ix638 (.Y (nx639), .A (nx78)) ;
    inv02 ix640 (.Y (nx641), .A (nx241)) ;
    inv02 ix642 (.Y (nx643), .A (nx641)) ;
    inv02 ix644 (.Y (nx645), .A (nx253)) ;
    inv02 ix646 (.Y (nx647), .A (nx645)) ;
    inv02 ix648 (.Y (nx649), .A (nx267)) ;
    inv02 ix650 (.Y (nx651), .A (nx649)) ;
    inv02 ix652 (.Y (nx653), .A (nx275)) ;
    inv02 ix654 (.Y (nx655), .A (nx653)) ;
    inv02 ix656 (.Y (nx657), .A (nx285)) ;
    inv02 ix658 (.Y (nx659), .A (nx657)) ;
    inv02 ix660 (.Y (nx661), .A (nx291)) ;
    inv02 ix662 (.Y (nx663), .A (nx661)) ;
    inv02 ix664 (.Y (nx665), .A (nx313)) ;
    inv02 ix666 (.Y (nx667), .A (nx665)) ;
    inv02 ix668 (.Y (nx669), .A (nx315)) ;
    inv02 ix670 (.Y (nx671), .A (nx669)) ;
    inv02 ix672 (.Y (nx673), .A (nx317)) ;
    inv02 ix674 (.Y (nx675), .A (nx673)) ;
    inv02 ix676 (.Y (nx677), .A (nx319)) ;
    inv02 ix678 (.Y (nx679), .A (nx677)) ;
    inv02 ix680 (.Y (nx681), .A (nx321)) ;
    inv02 ix682 (.Y (nx683), .A (nx681)) ;
    inv02 ix684 (.Y (nx685), .A (nx323)) ;
    inv02 ix686 (.Y (nx687), .A (nx685)) ;
    inv02 ix688 (.Y (nx689), .A (nx333)) ;
    inv02 ix690 (.Y (nx691), .A (nx689)) ;
    inv02 ix692 (.Y (nx693), .A (nx335)) ;
    inv02 ix694 (.Y (nx695), .A (nx693)) ;
    inv02 ix696 (.Y (nx697), .A (nx337)) ;
    inv02 ix698 (.Y (nx699), .A (nx697)) ;
    inv02 ix700 (.Y (nx701), .A (nx339)) ;
    inv02 ix702 (.Y (nx703), .A (nx701)) ;
    inv02 ix704 (.Y (nx705), .A (nx341)) ;
    inv02 ix706 (.Y (nx707), .A (nx705)) ;
    inv02 ix708 (.Y (nx709), .A (nx343)) ;
    inv02 ix710 (.Y (nx711), .A (nx709)) ;
    inv02 ix712 (.Y (nx713), .A (nx353)) ;
    inv02 ix714 (.Y (nx715), .A (nx713)) ;
    inv02 ix716 (.Y (nx717), .A (nx355)) ;
    inv02 ix718 (.Y (nx719), .A (nx717)) ;
    inv02 ix720 (.Y (nx721), .A (nx357)) ;
    inv02 ix722 (.Y (nx723), .A (nx721)) ;
    inv02 ix724 (.Y (nx725), .A (nx359)) ;
    inv02 ix726 (.Y (nx727), .A (nx725)) ;
    inv02 ix728 (.Y (nx729), .A (nx361)) ;
    inv02 ix730 (.Y (nx731), .A (nx729)) ;
    inv02 ix732 (.Y (nx733), .A (nx363)) ;
    inv02 ix734 (.Y (nx735), .A (nx733)) ;
    inv02 ix736 (.Y (nx737), .A (nx373)) ;
    inv02 ix738 (.Y (nx739), .A (nx737)) ;
    inv02 ix740 (.Y (nx741), .A (nx375)) ;
    inv02 ix742 (.Y (nx743), .A (nx741)) ;
    inv02 ix744 (.Y (nx745), .A (nx377)) ;
    inv02 ix746 (.Y (nx747), .A (nx745)) ;
    inv02 ix748 (.Y (nx749), .A (nx379)) ;
    inv02 ix750 (.Y (nx751), .A (nx749)) ;
    inv02 ix752 (.Y (nx753), .A (nx381)) ;
    inv02 ix754 (.Y (nx755), .A (nx753)) ;
    inv02 ix756 (.Y (nx757), .A (nx383)) ;
    inv02 ix758 (.Y (nx759), .A (nx757)) ;
    inv02 ix760 (.Y (nx761), .A (nx393)) ;
    inv02 ix762 (.Y (nx763), .A (nx761)) ;
    inv02 ix764 (.Y (nx765), .A (nx395)) ;
    inv02 ix766 (.Y (nx767), .A (nx765)) ;
    inv02 ix768 (.Y (nx769), .A (nx397)) ;
    inv02 ix770 (.Y (nx771), .A (nx769)) ;
    inv02 ix772 (.Y (nx773), .A (nx399)) ;
    inv02 ix774 (.Y (nx775), .A (nx773)) ;
    inv02 ix776 (.Y (nx777), .A (nx401)) ;
    inv02 ix778 (.Y (nx779), .A (nx777)) ;
    inv02 ix780 (.Y (nx781), .A (nx403)) ;
    inv02 ix782 (.Y (nx783), .A (nx781)) ;
    inv02 ix784 (.Y (nx785), .A (nx413)) ;
    inv02 ix786 (.Y (nx787), .A (nx785)) ;
    inv02 ix788 (.Y (nx789), .A (nx415)) ;
    inv02 ix790 (.Y (nx791), .A (nx789)) ;
    inv02 ix792 (.Y (nx793), .A (nx417)) ;
    inv02 ix794 (.Y (nx795), .A (nx793)) ;
    inv02 ix796 (.Y (nx797), .A (nx419)) ;
    inv02 ix798 (.Y (nx799), .A (nx797)) ;
    inv02 ix800 (.Y (nx801), .A (nx421)) ;
    inv02 ix802 (.Y (nx803), .A (nx801)) ;
    inv02 ix804 (.Y (nx805), .A (nx423)) ;
    inv02 ix806 (.Y (nx807), .A (nx805)) ;
    inv02 ix808 (.Y (nx809), .A (nx433)) ;
    inv02 ix810 (.Y (nx811), .A (nx809)) ;
    inv02 ix812 (.Y (nx813), .A (nx435)) ;
    inv02 ix814 (.Y (nx815), .A (nx813)) ;
    inv02 ix816 (.Y (nx817), .A (nx437)) ;
    inv02 ix818 (.Y (nx819), .A (nx817)) ;
    inv02 ix820 (.Y (nx821), .A (nx439)) ;
    inv02 ix822 (.Y (nx823), .A (nx821)) ;
    inv02 ix824 (.Y (nx825), .A (nx441)) ;
    inv02 ix826 (.Y (nx827), .A (nx825)) ;
    inv02 ix828 (.Y (nx829), .A (nx443)) ;
    inv02 ix830 (.Y (nx831), .A (nx829)) ;
    inv04 ix836 (.Y (nx837), .A (nx249)) ;
    inv04 ix838 (.Y (nx839), .A (nx259)) ;
    inv04 ix840 (.Y (nx841), .A (nx281)) ;
    inv04 ix842 (.Y (nx843), .A (nx265)) ;
endmodule


module nbit_adder_12 ( a, b, cin, add_out ) ;

    input [11:0]a ;
    input [11:0]b ;
    input cin ;
    output [11:0]add_out ;

    wire temp_10, temp_9, temp_8, temp_7, temp_6, temp_5, b_4_rename, nx12, nx14, 
         nx16, nx18, nx20, nx22;
    wire [1:0] \$dummy ;




    assign add_out[3] = add_out[0] ;
    assign add_out[2] = add_out[0] ;
    assign add_out[1] = add_out[0] ;
    bit_adder_unfolded2 loop1_4_fx (.a (a[4]), .b (b_4_rename), .cin (add_out[0]
                        ), .s (add_out[4]), .cout (\$dummy [0])) ;
    bit_adder_unfolded0 loop1_5_fx (.a (a[5]), .b (add_out[0]), .cin (a[4]), .s (
                        add_out[5]), .cout (temp_5)) ;
    bit_adder_unfolded0 loop1_6_fx (.a (a[6]), .b (add_out[0]), .cin (nx22), .s (
                        add_out[6]), .cout (temp_6)) ;
    bit_adder_unfolded0 loop1_7_fx (.a (a[7]), .b (add_out[0]), .cin (nx20), .s (
                        add_out[7]), .cout (temp_7)) ;
    bit_adder_unfolded0 loop1_8_fx (.a (a[8]), .b (add_out[0]), .cin (nx18), .s (
                        add_out[8]), .cout (temp_8)) ;
    bit_adder_unfolded0 loop1_9_fx (.a (a[9]), .b (add_out[0]), .cin (nx16), .s (
                        add_out[9]), .cout (temp_9)) ;
    bit_adder_unfolded0 loop1_10_fx (.a (a[10]), .b (add_out[0]), .cin (nx14), .s (
                        add_out[10]), .cout (temp_10)) ;
    bit_adder_unfolded1 loop1_11_fx (.a (a[11]), .b (add_out[0]), .cin (nx12), .s (
                        add_out[11]), .cout (\$dummy [1])) ;
  
    buf02 ix11 (.Y (nx12), .A (temp_10)) ;
    buf02 ix13 (.Y (nx14), .A (temp_9)) ;
    buf02 ix15 (.Y (nx16), .A (temp_8)) ;
    buf02 ix17 (.Y (nx18), .A (temp_7)) ;
    buf02 ix19 (.Y (nx20), .A (temp_6)) ;
    buf02 ix21 (.Y (nx22), .A (temp_5)) ;
endmodule


module bit_adder_unfolded2 ( a, b, cin, s, cout ) ;

    input a ;
    input b ;
    input cin ;
    output s ;
    output cout ;




    inv02 ix48 (.Y (s), .A (a)) ;
endmodule


module nbit_adder_8 ( a, b, cin, add_out ) ;

    input [7:0]a ;
    input [7:0]b ;
    input cin ;
    output [7:0]add_out ;

    wire temp_6, temp_5, temp_4, temp_3, temp_2, temp_1, cin_rename, b_7_rename, 
         nx12, nx14, nx16, nx18, nx20, nx22;
    wire [1:0] \$dummy ;




    bit_adder f0 (.a (a[0]), .b (b_7_rename), .cin (cin_rename), .s (add_out[0])
              , .cout (\$dummy [0])) ;
    bit_adder_unfolded0 loop1_1_fx (.a (a[1]), .b (b_7_rename), .cin (a[0]), .s (
                        add_out[1]), .cout (temp_1)) ;
    bit_adder_unfolded0 loop1_2_fx (.a (a[2]), .b (b_7_rename), .cin (nx22), .s (
                        add_out[2]), .cout (temp_2)) ;
    bit_adder_unfolded0 loop1_3_fx (.a (a[3]), .b (b_7_rename), .cin (nx20), .s (
                        add_out[3]), .cout (temp_3)) ;
    bit_adder_unfolded0 loop1_4_fx (.a (a[4]), .b (b_7_rename), .cin (nx18), .s (
                        add_out[4]), .cout (temp_4)) ;
    bit_adder_unfolded0 loop1_5_fx (.a (a[5]), .b (b_7_rename), .cin (nx16), .s (
                        add_out[5]), .cout (temp_5)) ;
    bit_adder_unfolded0 loop1_6_fx (.a (a[6]), .b (b_7_rename), .cin (nx14), .s (
                        add_out[6]), .cout (temp_6)) ;
    bit_adder_unfolded1 loop1_7_fx (.a (a[7]), .b (b_7_rename), .cin (nx12), .s (
                        add_out[7]), .cout (\$dummy [1])) ;
  
    buf02 ix11 (.Y (nx12), .A (temp_6)) ;
    buf02 ix13 (.Y (nx14), .A (temp_5)) ;
    buf02 ix15 (.Y (nx16), .A (temp_4)) ;
    buf02 ix17 (.Y (nx18), .A (temp_3)) ;
    buf02 ix19 (.Y (nx20), .A (temp_2)) ;
    buf02 ix21 (.Y (nx22), .A (temp_1)) ;
endmodule


module bit_adder_unfolded1 ( a, b, cin, s, cout ) ;

    input a ;
    input b ;
    input cin ;
    output s ;
    output cout ;


    xor2 ix1 (.Y (s), .A0 (cin), .A1 (a)) ;
endmodule


module bit_adder_unfolded0 ( a, b, cin, s, cout ) ;

    input a ;
    input b ;
    input cin ;
    output s ;
    output cout ;

    wire nx64;



    and02 ix1 (.Y (cout), .A0 (cin), .A1 (a)) ;
    nor02_2x ix7 (.Y (s), .A0 (cout), .A1 (nx64)) ;
    nor02_2x ix65 (.Y (nx64), .A0 (a), .A1 (cin)) ;
endmodule


module bit_adder ( a, b, cin, s, cout ) ;

    input a ;
    input b ;
    input cin ;
    output s ;
    output cout ;


    inv02 ix44 (.Y (s), .A (a)) ;
endmodule


module nbit_Register_12 ( Clk, rst, enable, d, rst_value, q ) ;

    input Clk ;
    input rst ;
    input enable ;
    input [11:0]d ;
    input [11:0]rst_value ;
    output [11:0]q ;

    wire nx63, nx73, nx83, nx93, nx103, nx113, nx123, nx133, nx143, nx153, nx163, 
         nx173, nx185, nx187, nx228, nx230, nx232, nx238, nx240, nx242;
    wire [11:0] \$dummy ;




    dff reg_q_0 (.Q (q[0]), .QB (\$dummy [0]), .D (nx63), .CLK (Clk)) ;
    ao32 ix64 (.Y (nx63), .A0 (d[0]), .A1 (nx228), .A2 (nx238), .B0 (q[0]), .B1 (
         nx230)) ;
    inv02 ix186 (.Y (nx185), .A (rst)) ;
    nor02_2x ix188 (.Y (nx187), .A0 (rst), .A1 (nx238)) ;
    dff reg_q_1 (.Q (q[1]), .QB (\$dummy [1]), .D (nx73), .CLK (Clk)) ;
    ao32 ix74 (.Y (nx73), .A0 (d[1]), .A1 (nx228), .A2 (nx238), .B0 (q[1]), .B1 (
         nx230)) ;
    dff reg_q_2 (.Q (q[2]), .QB (\$dummy [2]), .D (nx83), .CLK (Clk)) ;
    ao32 ix84 (.Y (nx83), .A0 (d[2]), .A1 (nx228), .A2 (nx238), .B0 (q[2]), .B1 (
         nx230)) ;
    dff reg_q_3 (.Q (q[3]), .QB (\$dummy [3]), .D (nx93), .CLK (Clk)) ;
    ao32 ix94 (.Y (nx93), .A0 (d[3]), .A1 (nx228), .A2 (nx238), .B0 (q[3]), .B1 (
         nx230)) ;
    dff reg_q_4 (.Q (q[4]), .QB (\$dummy [4]), .D (nx103), .CLK (Clk)) ;
    ao32 ix104 (.Y (nx103), .A0 (d[4]), .A1 (nx228), .A2 (nx238), .B0 (q[4]), .B1 (
         nx230)) ;
    dff reg_q_5 (.Q (q[5]), .QB (\$dummy [5]), .D (nx113), .CLK (Clk)) ;
    ao32 ix114 (.Y (nx113), .A0 (d[5]), .A1 (nx228), .A2 (nx240), .B0 (q[5]), .B1 (
         nx230)) ;
    dff reg_q_6 (.Q (q[6]), .QB (\$dummy [6]), .D (nx123), .CLK (Clk)) ;
    ao32 ix124 (.Y (nx123), .A0 (d[6]), .A1 (nx185), .A2 (nx240), .B0 (q[6]), .B1 (
         nx232)) ;
    dff reg_q_7 (.Q (q[7]), .QB (\$dummy [7]), .D (nx133), .CLK (Clk)) ;
    ao32 ix134 (.Y (nx133), .A0 (d[7]), .A1 (nx185), .A2 (nx240), .B0 (q[7]), .B1 (
         nx232)) ;
    dff reg_q_8 (.Q (q[8]), .QB (\$dummy [8]), .D (nx143), .CLK (Clk)) ;
    ao32 ix144 (.Y (nx143), .A0 (d[8]), .A1 (nx185), .A2 (nx240), .B0 (q[8]), .B1 (
         nx232)) ;
    dff reg_q_9 (.Q (q[9]), .QB (\$dummy [9]), .D (nx153), .CLK (Clk)) ;
    ao32 ix154 (.Y (nx153), .A0 (d[9]), .A1 (nx185), .A2 (nx240), .B0 (q[9]), .B1 (
         nx232)) ;
    dff reg_q_10 (.Q (q[10]), .QB (\$dummy [10]), .D (nx163), .CLK (Clk)) ;
    ao32 ix164 (.Y (nx163), .A0 (d[10]), .A1 (nx185), .A2 (nx240), .B0 (q[10]), 
         .B1 (nx232)) ;
    dff reg_q_11 (.Q (q[11]), .QB (\$dummy [11]), .D (nx173), .CLK (Clk)) ;
    ao32 ix174 (.Y (nx173), .A0 (d[11]), .A1 (nx185), .A2 (nx242), .B0 (q[11]), 
         .B1 (nx232)) ;
    inv02 ix227 (.Y (nx228), .A (rst)) ;
    buf02 ix229 (.Y (nx230), .A (nx187)) ;
    buf02 ix231 (.Y (nx232), .A (nx187)) ;
    buf02 ix237 (.Y (nx238), .A (enable)) ;
    buf02 ix239 (.Y (nx240), .A (enable)) ;
    buf02 ix241 (.Y (nx242), .A (enable)) ;
endmodule


module nbit_Register_8 ( Clk, rst, enable, d, rst_value, q ) ;

    input Clk ;
    input rst ;
    input enable ;
    input [7:0]d ;
    input [7:0]rst_value ;
    output [7:0]q ;

    wire nx55, nx65, nx75, nx85, nx95, nx105, nx115, nx125, nx137, nx139, nx168, 
         nx170, nx176, nx178;
    wire [7:0] \$dummy ;




    dff reg_q_0 (.Q (q[0]), .QB (\$dummy [0]), .D (nx55), .CLK (Clk)) ;
    ao32 ix56 (.Y (nx55), .A0 (d[0]), .A1 (nx168), .A2 (nx176), .B0 (q[0]), .B1 (
         nx170)) ;
    inv02 ix138 (.Y (nx137), .A (rst)) ;
    nor02_2x ix140 (.Y (nx139), .A0 (rst), .A1 (nx176)) ;
    dff reg_q_1 (.Q (q[1]), .QB (\$dummy [1]), .D (nx65), .CLK (Clk)) ;
    ao32 ix66 (.Y (nx65), .A0 (d[1]), .A1 (nx168), .A2 (nx176), .B0 (q[1]), .B1 (
         nx170)) ;
    dff reg_q_2 (.Q (q[2]), .QB (\$dummy [2]), .D (nx75), .CLK (Clk)) ;
    ao32 ix76 (.Y (nx75), .A0 (d[2]), .A1 (nx168), .A2 (nx176), .B0 (q[2]), .B1 (
         nx170)) ;
    dff reg_q_3 (.Q (q[3]), .QB (\$dummy [3]), .D (nx85), .CLK (Clk)) ;
    ao32 ix86 (.Y (nx85), .A0 (d[3]), .A1 (nx168), .A2 (nx176), .B0 (q[3]), .B1 (
         nx170)) ;
    dff reg_q_4 (.Q (q[4]), .QB (\$dummy [4]), .D (nx95), .CLK (Clk)) ;
    ao32 ix96 (.Y (nx95), .A0 (d[4]), .A1 (nx168), .A2 (nx176), .B0 (q[4]), .B1 (
         nx170)) ;
    dff reg_q_5 (.Q (q[5]), .QB (\$dummy [5]), .D (nx105), .CLK (Clk)) ;
    ao32 ix106 (.Y (nx105), .A0 (d[5]), .A1 (nx168), .A2 (nx178), .B0 (q[5]), .B1 (
         nx139)) ;
    dff reg_q_6 (.Q (q[6]), .QB (\$dummy [6]), .D (nx115), .CLK (Clk)) ;
    ao32 ix116 (.Y (nx115), .A0 (d[6]), .A1 (nx137), .A2 (nx178), .B0 (q[6]), .B1 (
         nx139)) ;
    dff reg_q_7 (.Q (q[7]), .QB (\$dummy [7]), .D (nx125), .CLK (Clk)) ;
    ao32 ix126 (.Y (nx125), .A0 (d[7]), .A1 (nx137), .A2 (nx178), .B0 (q[7]), .B1 (
         nx139)) ;
    inv02 ix167 (.Y (nx168), .A (rst)) ;
    nor02_2x ix169 (.Y (nx170), .A0 (rst), .A1 (nx178)) ;
    buf04 ix175 (.Y (nx176), .A (enable)) ;
    buf04 ix177 (.Y (nx178), .A (enable)) ;
endmodule


module DMACU ( clk, reset, start_DMA, Rows_Done, Row_Done, signals ) ;

    input clk ;
    input reset ;
    input start_DMA ;
    input Rows_Done ;
    input Row_Done ;
    output [5:0]signals ;

    wire state_4, state_1, nx4, nx12, nx28, nx40, nx62, nx74, nx36, nx48, nx51, 
         nx53, nx57, nx70, nx72, nx78, nx80;
    wire [5:0] \$dummy ;


    or02 ix83 (.Y (signals[3]), .A0 (signals[4]), .A1 (state_4)) ;
    dff reg_state_2 (.Q (signals[4]), .QB (\$dummy [0]), .D (nx40), .CLK (clk)
        ) ;
    and03 ix41 (.Y (nx40), .A0 (state_1), .A1 (nx57), .A2 (start_DMA)) ;
    dff reg_state_1 (.Q (state_1), .QB (\$dummy [1]), .D (nx28), .CLK (clk)) ;
    nor02_2x ix29 (.Y (nx28), .A0 (reset), .A1 (nx70)) ;
    inv02 ix37 (.Y (nx36), .A (start_DMA)) ;
    dff reg_state_0 (.Q (signals[1]), .QB (\$dummy [2]), .D (nx12), .CLK (clk)
        ) ;
    or02 ix13 (.Y (nx12), .A0 (signals[0]), .A1 (reset)) ;
    dff reg_state_5 (.Q (signals[0]), .QB (\$dummy [3]), .D (nx4), .CLK (clk)) ;
    and03 ix5 (.Y (nx4), .A0 (state_4), .A1 (nx57), .A2 (Rows_Done)) ;
    dff reg_state_4 (.Q (state_4), .QB (\$dummy [4]), .D (nx74), .CLK (clk)) ;
    and03 ix75 (.Y (nx74), .A0 (signals[5]), .A1 (nx57), .A2 (Row_Done)) ;
    dff reg_state_3 (.Q (signals[5]), .QB (\$dummy [5]), .D (nx62), .CLK (clk)
        ) ;
    nor02_2x ix63 (.Y (nx62), .A0 (reset), .A1 (nx72)) ;
    aoi221 ix50 (.Y (nx48), .A0 (nx51), .A1 (state_4), .B0 (nx53), .B1 (
           signals[5]), .C0 (signals[4])) ;
    inv02 ix52 (.Y (nx51), .A (Rows_Done)) ;
    inv02 ix54 (.Y (nx53), .A (Row_Done)) ;
    inv02 ix58 (.Y (nx57), .A (reset)) ;
    buf02 ix69 (.Y (nx70), .A (nx80)) ;
    buf02 ix71 (.Y (nx72), .A (nx48)) ;
    inv02 ix79 (.Y (nx80), .A (nx78)) ;
    ao21 ix35 (.Y (nx78), .A0 (nx36), .A1 (state_1), .B0 (signals[1])) ;
endmodule

