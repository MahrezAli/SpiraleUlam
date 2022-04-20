#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying float idValeur;
varying vec4 vertColor;
void main() {
  float n = idValeur;
  float N0 = mod(n, 256.0);
  float N1 = mod(((n - N0)/256.0), 256.0);
  float N2 = mod (((n - N0 - N1*256)/256.0*256.0), 256.0);
  gl_FragColor = vec4(N2/255.0, N1/255.0, N0/255.0, 1.0);
} 
