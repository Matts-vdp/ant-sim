# ant-sim
 An ant simulator that simulates a colony searching for food.
 
## Search for food
 When searching for food an ant will walk and look for any food markers or food in its view range.
 If a food marker enters the area the ant will move to it. When multiple markers are inside the area 
 the average position is calculated.
 Because of this if for example a marker path splits the path with a higher density of markers will be followed.
 While walking around home markers will be dropped.
 
## Returning home
 When food is found the ant will turn around and start dropping food markers instead of home markers to show other ants where the food came from.
 To find the way back home the ant will look for home markers in the same way it looked for food markers in the food searching step.
 Because the density of home markers is higher near their home they will be able to follow the markers to it.
 
## Known issues
 * Ants will get lost occasionally but most of the time this will solve itself.
 * Because of the high amounts of markers and ants there are some performance issues so don't expect a high frame rate.
 

## Preview
This preview has been sped up.

https://user-images.githubusercontent.com/70054706/128490053-c572e8c1-3e94-4701-a09b-8bbeea995d98.mp4
