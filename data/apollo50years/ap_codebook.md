
## Dataset Apollo Manned Flight ##  
Sources: NASA HQ Astronaut Files, Wikipedia  
Reduced version: 2019-01-02
Contributor: Swaran Sandhu | sandhu@hdm-stuttgart.de  

*Focus*:   
2019 marks the 50th anniversary of the Apollo 11 moon landing. I am interested in the relationship between the Apollo Crews.  

### Codebook Edgelist  
from: Astronaut (last name)   
to: Mission flow (mission name)  
role: role during flight  
moon: landed on moon (i.d. moonwalker)  
year: year of mission  
launch: launchdate of mission, coded as yyyy-mm-dd  

from: Astronaut (last name)   
to: Mission flown (spacecraft)  
function:  
1 = Crew (actual flight crew)  
2 = Backup Crew  
3 = Support Crew  
4 = Capcom (special duty to community with the capsule, designated role for astronauts) 

moon:  
0 = no moon   
1 = moonwalker (Lunar Module Pilot and Commander)   
2 = moonflyer (piloting command module)  
  
### Codebook Nodelist  
  
type:  
0 = astronaut
1 = spaceflight/mission

background:
1 = Navy  
2 = Air Force  
3 = Marine Corps  
4 = Civilian  

group: orginal selection for training  
1 = Astronaut Group 1 1959 (Mercury 7)  
2 = Astronaut Group 2 1962 (New Nine)  
3 = Astronaut Group 3 1963 (The Fourteen)     
4 = Astronaut Group 4 1965 (The Scientists)    
5 = Astronaut Group 5 1966 (The Original 19)    
6 = Astronaut Group 6 1967 (XS-11)  
7 = Astronaut Group 7 1969   
   
testpilot:  
active duty as designated testpilot?  
1 = yes  
2 = no  
  
  
moon: Connection to moon  
1 = moonwalker (on the surface)  
2 = moon orbit (test flight)  
3 = command module pilot with surface landing (docking of lunar module)  
4 = moon orbit due to aborted mission (Apollo 13), scheduled for moon landing  
  
boyscout: yes/no  
boyscout_rank: rank in the boyscouts     
  
career: primary field of career after Apollo-Program (last occupation): 
no clear distinction possible, exploratory
  
freemason: yes/no  
member of a freemason lodge  
  




