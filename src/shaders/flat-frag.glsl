#version 300 es
precision highp float;

uniform vec3 u_Eye, u_Ref, u_Up;
uniform vec2 u_Dimensions;
uniform float u_Time;

in vec2 fs_Pos;
out vec4 out_Col;

vec3 getDirection(vec2 uv) {
  vec3 look = normalize(u_Ref - u_Eye);
  vec3 right = normalize(cross(look, u_Up));
  vec3 up = cross(right, look);

  float aspect_ratio = u_Dimensions.x / u_Dimensions.y;
  vec3 vertical = up * tan(1.0);
  vec3 horizontal = right * aspect_ratio * tan(1.0);
  vec3 screen_point = (look + uv.x * horizontal + uv.y * vertical);

  return normalize(screen_point - u_Eye);
}

void main() {
  vec2 uv = fs_Pos;
  uv = uv * 2.0 - 1.0;
  
  vec3 dir = getDirection(uv);

  vec3 color = 0.5 * (dir + vec3(1.0));

  // out_Col = vec4(0.5 * (fs_Pos + vec2(1.0)), 0.5 * (sin(u_Time * 3.14159 * 0.01) + 1.0), 1.0);
  out_Col = vec4(color, 1.0);
  // out_Col = vec4(fs_Pos, 1., 1.);
}
