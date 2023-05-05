
/*
 GLSL functions

vec3 hsv2rgb(vec3 c) 
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}



bool point_in_elipse(vec2 center, vec2 point, vec2 axis)
{
    vec2 semi_axis = vec2(max(axis.x, axis.y), min(axis.x, axis.y));
    
    float p = (pow((point.x - center.x), 2.0) / pow(semi_axis.x, 2.0))
            + (pow((point.y - center.y), 2.0) / pow(semi_axis.y, 2.0));
            
    bool ans = p <= 1.0 ? true : false;
    return ans;
}



float mx = iMouse.x/iResolution.x;
float my = iMouse.y/iResolution.y;
    
float dir = atan(my-0.5, mx-0.5);
    
vec2 direction = vec2(cos(dir), sin(dir));




vec3 hex_to_rgb(float color) {    
    float r = mod((color / 256.0 / 256.0), 256.0);    
    float g = mod((color / 256.0        ), 256.0);    
    float b = mod((color                ), 256.0);        
    return vec3(r / 255.0, g / 255.0, b / 255.0);
}





// Identidy matrix
mat4 mat_identidy() {
    return mat4(
        1.0,    0.0,    0.0,    0.0,
        0.0,    1.0,    0.0,    0.0,
        0.0,    0.0,    1.0,    0.0,
        0.0,    0.0,    0.0,    1.0
    );
}

// Position matrix
mat4 mat_pos(vec3 p) {
    return mat4(
        1.0,    0.0,    0.0,    0.0,
        0.0,    1.0,    0.0,    0.0,
        0.0,    0.0,    1.0,    0.0,
        p.x,    p.y,    p.z,    1.0
    );
}

// Rotation matrix
mat4 mat_xrot(float a) {
    float ac = cos(a);
    float as = sin(a);
    return mat4(
        1.0,    0.0,    0.0,    0.0,
        0.0,    +ac,    +as,    0.0,
        0.0,    -as,    +ac,    0.0,
        0.0,    0.0,    0.0,    1.0
    );
}

mat4 mat_yrot(float a) {
    float ac = cos(a);
    float as = sin(a);
    return mat4(
        +ac,    0.0,    -as,    0.0,
        0.0,    1.0,    0.0,    0.0,
        +as,    0.0,    +ac,    0.0,
        0.0,    0.0,    0.0,    1.0
    );
}

mat4 mat_zrot(float a) {
    float ac = cos(a);
    float as = sin(a);
    return mat4(
        +ac,    +as,    0.0,    0.0,
        -as,    +ac,    0.0,    0.0,
        0.0,    0.0,    1.0,    0.0,
        0.0,    0.0,    0.0,    1.0
    );
}

// Scale matrix
mat4 mat_scale(vec3 s) {
    return mat4(
        s.x,    0.0,    0.0,    0.0,
        0.0,    s.y,    0.0,    0.0,
        0.0,    0.0,    s.z,    0.0,
        0.0,    0.0,    0.0,    1.0
    );
}
}


float gray = dot(fragcol.rgb, vec3(0.299, 0.587, 0.114));



mat4 proj_mat    = gm_Matrices[MATRIX_PROJECTION];
mat4 view_mat    = gm_Matrices[MATRIX_VIEW];
mat4 world_mat    = gm_Matrices[MATRIX_WORLD];

mat4 world_view_proj_mat    = proj_mat * view_mat * world_mat;
vec4 world_space_pos        = vec4(in_Position, 1.0);

gl_Position = world_view_proj_mat * world_space_pos;




float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}




float map_value(float val, vec2 curr, vec2 dest) {
    return (((val - curr.x) / (curr.y- curr.x)) * (dest.y - dest.x)) + dest.x;
}

vec2 normalize_uv(vec2 val, vec4 uvs) {
    return vec2(
        map_value(val.x, vec2(uvs[0], uvs[2]), vec2(0.0, 1.0)), 
        map_value(val.y, vec2(uvs[1], uvs[3]), vec2(0.0, 1.0)));
}

vec2 remap_uv(vec2 val, vec4 uvs) {
    return vec2(
        map_value(val.x, vec2(0.0, 1.0), vec2(uvs[0], uvs[2])), 
        map_value(val.y, vec2(0.0, 1.0), vec2(uvs[1], uvs[3])));
}



vec2 normalize_coord(vec2 val, vec4 uvs) {
    //return vec2(
    //    (val.x - uvs.x) / (uvs.z - uvs.x), 
    //    (val.y - uvs.y) / (uvs.w - uvs.y));
    return (val - uvs-xy) / uvs.zw;
}

vec2 remap_coord(vec2 val, vec4 uvs) {
    //return vec2(
    //    mix(uvs.x, uvs.z, val.x),
    //    mix(uvs.y, uvs.w, val.y)); 
    return val * uvs.zw + uvs.xy;
}



vec2 hash2(vec2 p) {
    return fract(sin(p * mat2(0.129898, 0.81314, 0.78233,  0.15926)) * 43758.5453);
}

vec2 hash2_norm(vec2 p) {
    return normalize(hash2(p) - 0.5);
}

float perlin_noise(vec2 p) {
    vec2 cell = floor(p);
    vec2 sub = p - cell; 
    vec2 quint = sub*sub*sub*(10.0 + sub*(-15.0 + 6.0*sub));
    const vec2 off = vec2(0,1); 
    
    float grad_corner00 = dot(hash2_norm(cell+off.xx), off.xx-sub);
    float grad_corner10 = dot(hash2_norm(cell+off.yx), off.yx-sub);
    float grad_corner01 = dot(hash2_norm(cell+off.xy), off.xy-sub);
    float grad_corner11 = dot(hash2_norm(cell+off.yy), off.yy-sub);

    return mix(mix(grad_corner00, grad_corner10, quint.x),
               mix(grad_corner01, grad_corner11, quint.x), quint.y) * 0.7 + 0.5;
}



//Pi constant
#define pi 3.1415926535897932384626433832795

//General functions
#define frac(x)         fract(abs(x))*sign(x)
#define round(x)        floor((x)+0.5)
#define lerp(a,b,x)     mix(a,b,x)

//Comparison functions (number depends on arguments)
#define max3(a,b,c)         max(a,max(b,c))
#define max4(a,b,c,d)       max(a,max(b,max(c,d)))
#define max5(a,b,c,d,e)     max(a,max(b,max(c,max(d,e))))
#define min3(a,b,c)         min(a,min(b,c))
#define min4(a,b,c,d)       min(a,min(b,min(c,d)))
#define min5(a,b,c,d,e)     min(a,min(b,min(c,min(d,e))))
#define mean2(a,b)          ((a)+(b))/2.0
#define mean3(a,b,c)        ((a)+(b)+(c))/3.0
#define mean4(a,b,c,d)      ((a)+(b)+(c)+(d))/4.0
#define mean5(a,b,c,d,e)    ((a)+(b)+(c)+(d)+(e))/5.0

//Exponent functions
#define sqr(x)      (x)*(x)
#define power(x,y)  pow(x,y)
#define log10(x)    log(x)/log(10.0)
#define logn(b,x)   log(x)/log(b)
#define ln(x)       log(x)

//Trigonometry functions
#define dcos(x)         cos(radians(x))
#define dsin(x)         sin(radians(x))
#define dtan(x)         tan(radians(x))
#define darccos(x)      acos(radians(x))
#define darcsin(x)      asin(radians(x))
#define darctan(x)      atan(radians(x))
#define darctan2(y,x)   atan(radians(y), radians(x))
#define arccos(x)       acos(x)
#define arcsin(x)       asin(x)
#define arctan(x)       atan(x)
#define arctan2(y,x)    atan(y, x)

//Angle functions
#define angle_difference(d,s)   (mod(d-s+180.0, 360.0)-180.0)
#define degtorad(x)             radians(x)
#define radtodeg(x)             degrees(x)
#define lengthdir_x(l,d)        +(l)*cos(radians(d))
#define lengthdir_y(l,d)        -(l)*sin(radians(d))

//Vector functions
#define point_direction(x1,y1,x2,y2)                    mod(degrees(atan(y2-y1, x2-x1)), 360.0)
#define point_direction_vec(p1,p2)                      mod(degrees(atan((p2-p1).x, (p2-p1).y)), 360.0)
#define point_distance(x1,y1,x2,y2)                     distance(vec2(x1,y1), vec2(x2,y2))
#define point_distance_3d(x1,y1,z1,x2,y2,z2)            distance(vec3(x1,y1,z1), vec3(x2,y2,z2))
#define point_distance_vec(p1,p2)                       distance(p1, p2)
#define dot_product(x1,y1,x2,y2)                        dot(vec2(x1,y1), vec2(x2,y2))
#define dot_product_3d(x1,y1,z1,x2,y2,z2)               dot(vec3(x1,y1,z1), vec3(x2,y2,z2))
#define dot_product_vec(v1,v2)                          dot(v1, v2)
#define dot_product_normalised(x1,y1,x2,y2)             dot(normalize(vec2(x1,y1)), normalize(vec2(x2,y2)))
#define dot_product_normalised_vec(v1,v2)               dot(normalize(v1), normalize(v2))
#define dot_product_normalised_3d(x1,y1,z1,x2,y2,z2)    dot(normalize(vec3(x1,y1,z1)), normalize(vec3(x2,y2,z2)))

//Random functions (cheap approximation)
float seed = 0.0;
#define random(x)           (x)*fract(cos(++seed*97.)*4e3)
#define irandom(x)          floor((x)*fract(cos(++seed*97.)*4e3))
#define random_set_seed(s)  seed=(s)
#define random_get_seed(s)  seed
*/