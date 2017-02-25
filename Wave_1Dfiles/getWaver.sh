#!/bin/csh

foreach task(NS CS US SW)

	waver -TR 2 -numout 888 -peak 1.0 -input "$task"1D.mx > "$task"1D.1d



end

