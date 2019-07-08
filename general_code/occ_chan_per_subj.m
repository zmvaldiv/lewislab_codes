function occchan=occ_chan_per_subj(subj)
% selected manually as a channel that has high occipital alpha at baseline,
% and looks high quality in cleaned MR data
% run allchans_eyesOC

switch subj
   case 'osceeg2b'
       occchan=126; % not great
   case 'osceeg3b'
       occchan=136;
   case 'osceeg5b'
       occchan=139;
   case 'osceeg6b'
       occchan=136;
   case 'osceeg7b'
       occchan=116;
   case 'osceeg8b'
       occchan=126;
   case 'osceeg9b'
       occchan=124;
   case 'osceeg10b'
       occchan=124;
   case 'osceeg15b'
       occchan=136;
   case 'osceeg17b'
       occchan=118;
   case 'osceeg19b'
       occchan=138;
   case 'osceeg20b'
       occchan=125; % look into quality further
   case 'osceeg21b'
       occchan=137;
   case 'osceeg22b'
       occchan=116;
   case 'inkrefcap1'
       occchan=116;
   case 'inkrefcap2'
       occchan=126;
   case 'inkrefcap3'
       occchan=126; % pretty bad
   case 'inkrefcap4'
       occchan=150; % bad
   case 'inkrefcap5'
       occchan=117;
   case 'inkrefcap6'
       occchan=116;
   case 'inkrefcap7'
       occchan=116;
   case 'inkrefcap7b'
       occchan=118;
   case 'inkrefcap8'
       occchan=118;
   case 'inkrefcap9a'
       occchan=126;
end
