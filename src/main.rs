use wgpu_cg::run;

fn main() {
    pollster::block_on(run());
}