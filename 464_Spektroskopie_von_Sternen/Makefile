.PHONY: halpha winde plot copy

halpha:
	cd src;\
		python halpha.py

winde:
	cd src;\
		python winde.py

plot:
	cd plot;\
		rm *.aux *.pdf *.tex *.fdb_latexmk;\
		gnuplot plot.gnu;\
		gnuplot plot_gauss.gnu;\
		gnuplot plot_kali.gnu;\
		gnuplot plot_winde.gnu;\
		gnuplot plot_doublet.gnu;\
		gnuplot plot_pcygni_spectra.gnu;\
		gnuplot plot_aq.gnu

copy:
	cp -t latex plot/*.tex plot/*.pdf
		

