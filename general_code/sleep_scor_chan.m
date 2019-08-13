function channel = sleep_scor_chan(subject)
channel{1,1} = 'F3';
channel{2,1} = 'F4';
channel{3,1} = 'C3';
channel{4,1} = 'C4';
channel{5,1} = 'O1';
channel{6,1} = 'O2';
channel{7,1} = 'L. Eye';
channel{8,1} = 'R. Eye';

channel{1,2} = 36;
channel{2,2} = 224;
channel{3,2} = 59;
channel{4,2} = 183;
channel{5,2} = 116;
channel{6,2} = 150;
channel{7,2} = 248;
channel{8,2} = 10;

switch subject
   case 'osceeg15b'
       channel{2,2} = 207;
       channel{3,2} = 52;
   case 'osceeg17b'
       channel{1,2} = 30;
       channel{3,2} = 52;
       channel{5,2} = 125;
    case 'osceeg19b'
       channel{1,2} = 29;
       channel{3,2} = 52;
       channel{5,2} = 117;
       channel{2,2} = 215;
       channel{4,2} = 195;
       channel{6,2} = 138;
   case 'osceeg20b'
       channel{3,2} = 52;
       channel{5,2} = 125;
       channel{2,2} = 207;
       channel{4,2} = 195;
       channel{6,2} = 149;
   case 'osceeg21b'
       channel{3,2} = 52;
   case 'osceeg22b'
       channel{1,2} = 41;
       channel{3,2} = 58;
       channel{2,2} = 213;
       channel{6,2} = 138;
       channel{8,2} = 2;
end
