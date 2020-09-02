# TMDS-encoder-8b/10b
TMDS is a method for serially transmitting high-speed digital signals.  
The “transition minimized” part is realized by the 8b/10b encoding algorithm used by TMDS, which is implemented here in digital logic.  
This TMDS encoding is used in several digital communication interfaces, including the DVI and HDMI video interfaces. 
It is important to note that this TMDS encoding was created by Silicon Image in 1999 and is not the same as the original 8b/10b encoding introduced by IBM in 1983.  
The “differential signaling” part of the technique relates to the IO circuit and is not discussed in detail here.  
The TMDS encoding algorithm reduces electromagnetic emissions, achieves DC balance on the wires, and still allows for reliable clock recovery.  
The encoding seeks to minimize the transitions (thus reducing interference between channels) while still retaining frequent enough transitions for clock recovery. 
By keeping the number of ones and zeros on the line nearly equal, the DC balance part of the encoding algorithm improves the noise margin.

It is implemented using Xilinx ISE design Suite
