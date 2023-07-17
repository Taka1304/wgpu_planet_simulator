use wgpu_planet_simulator::run;

fn main() {
    pollster::block_on(run());
}