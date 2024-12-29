use std::borrow::BorrowMut;

use whisper_rs::{convert_integer_to_float_audio, WhisperContext, WhisperContextParameters, FullParams, SamplingStrategy};
use hound::{WavReader, SampleFormat};

fn read_audio_data(audio_path: String) -> Vec<i16> {
    let reader = WavReader::open(audio_path).unwrap();
    if reader.spec().channels != 1 {
        panic!("Only mono audio is supported");
    }
    if reader.spec().sample_format != SampleFormat::Int {
        panic!("Only integer audio is supported");
    }
    if reader.spec().sample_rate != 16000 {
        panic!("Only 16kHz audio is supported");
    }
    reader.into_samples::<i16>().map(|s| s.unwrap()).collect()
}

#[flutter_rust_bridge::frb(sync)]
pub fn run_whisper(model_path: String, audio_path: String, language: Option<String>) {
    let ctx = WhisperContext::new_with_params(&model_path, WhisperContextParameters::default()).unwrap();
    let mut params = FullParams::new(SamplingStrategy::Greedy { best_of: 1 });
    let audio_data = read_audio_data(audio_path);
    params.set_max_len(1);
    params.set_split_on_word(true);
    params.set_token_timestamps(true);
    params.set_print_progress(false);
    params.set_print_realtime(false);
    params.set_print_special(false);
    params.set_print_timestamps(false);
    let lang_code = language.unwrap_or("en".to_string());
    params.set_language(Some(&lang_code));
    let mut output = vec![0.0f32; audio_data.len()];
    convert_integer_to_float_audio(&audio_data, output.borrow_mut()).unwrap();
    let mut state = ctx.create_state().expect("failed to create state");
    state.full(params, &output).expect("failed to run model");
    let num_segments = state.full_n_segments().expect("failed to get number of segments");
    for i in 0..num_segments {
        let segment = state.full_get_segment_text(i).expect("failed to get segment");
        let start_timestamp = state.full_get_segment_t0(i).expect("failed to get start timestamp");
        let end_timestamp = state.full_get_segment_t1(i).expect("failed to get end timestamp");
        println!("[{} - {}]: {}", start_timestamp, end_timestamp, segment);
    }

}