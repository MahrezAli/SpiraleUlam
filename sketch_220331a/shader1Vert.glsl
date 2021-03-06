uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;

attribute float idnum;
attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying float idValeur;
varying vec4 vertColor;
 
void main() {
  gl_Position = transform * position;    
  vec3 ecPosition = vec3(modelview * position);  
  vec3 ecNormal = normalize(normalMatrix * normal);

  vec3 direction = normalize(lightPosition.xyz - ecPosition);    
  float intensity = max(0.0, dot(direction, ecNormal));
  idValeur = idnum;
  // Use the parameters above to compute vertColor e.g.
  vertColor = vec4(intensity, intensity, intensity, 1) * color;           
}
