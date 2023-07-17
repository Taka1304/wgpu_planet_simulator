// light shader
// Vertex shader

// カメラ情報を保持するCamera構造体
struct Camera {
    view_pos: vec4<f32>,   // カメラの位置
    view_proj: mat4x4<f32>,   // カメラのビュー行列とプロジェクション行列を掛けた行列
}
@group(0) @binding(0)
var<uniform> camera: Camera;   // シェーダーにおけるカメラの情報を保持するuniform変数

// 光源情報を保持するLight構造体
struct Light {
    position: vec3<f32>,   // 光源の位置
    color: vec3<f32>,   // 光源の色
}
@group(1) @binding(0)
var<uniform> light: Light;   // シェーダーにおける光源の情報を保持するuniform変数

// 頂点入力情報を保持するVertexInput構造体
struct VertexInput {
    @location(0) position: vec3<f32>,   // 頂点の位置情報
};

// 頂点出力情報を保持するVertexOutput構造体
struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,   // クリップ座標系での位置
    @location(0) color: vec3<f32>,   // 頂点の色情報
};

// 頂点シェーダー
@vertex
fn vs_main(
    model: VertexInput,   // 入力モデル情報
) -> VertexOutput {
    let scale = 0.1;   // スケール係数
    var out: VertexOutput;   // 出力情報を格納する変数
    out.clip_position = camera.view_proj * vec4<f32>(model.position * scale + light.position, 1.0);   // クリップ座標系での位置を計算
    out.color = light.color;   // 出力色を光源の色に設定
    return out;   // 出力情報を返す
}

// Fragment shader

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);   // 入力の色情報を出力する
}
