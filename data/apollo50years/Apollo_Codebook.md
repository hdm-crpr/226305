## Dataset Apollo Manned Flight ##  
Sources: NASA HQ Astronaut Files, Wikipedia  
First version: 2018-12-31  
Contributor: Swaran Sandhu | sandhu@hdm-stuttgart.de  

*Focus*:   
2019 marks the 50th anniversary of the Apollo 11 moon landing. I am interested in the relationship between the Apollo Crews.  

### Codebook Edgelist  
from: Astronaut (last name)   
to: Mission flow (mission name)  
function: role during flight  
moon: landed on moon (i.d. moonwalker)  
launch: launchdate of mission, coded as yyyy-mm-dd  

### Codebook Edgelist numeric
from: Astronaut (last name)   
to: Mission flown (spacecraft)  
function:  
1 = Crew (actual flight crew)  
2 = Backup Crew  
3 = Support Crew  

group: orginal selection for training
1 = Astronaut Group 1 1959 (Mercury 7)  
2 = Astronaut Group 2 1962 (New Nine)  
3 = Astronaut Group 3 1963 (The Fourteen)     
4 = Astronaut Group 4 1965 (The Scientists)    
5 = Astronaut Group 5 1966 (The Original 19)   

moon:  
0 = no moon  
1 = moonwalker (Lunar Module Pilot and Commander)  
2 = moonflyer (piloting command module)  
  
launch: launchdate of mission, coded as yyyy-mm-dd 
  
sequence: time series for animation  
sequence_app: time series only for Apollo missions  

  
### Codebook Nodelist  
  
background:
1 = Navy  
2 = Air Force  
3 = Marine Corps  
4 = Civilian  
  
testpilot: active duty as designated testpilot?  
bachelor: year  
master: year  
phd: yes/no  
almamater1: bachelor degree  
almamater2: master or PhD degree  
marriage: yes/no/NA at the time of the Apollo Program  
kids: number, preferably at the Apollo Program  
divorced: after Apollo program  
religion: religious orientation, if available  
moonwalker: yes, no  
boyscout_rank: rank in the boyscout    
boyscout: yes, no  
career: primary field of career after Apollo-Program (last occupation)  
freemason: member of a freemason lodge  
fraternity: member of a fraternity  
  




