import librosa
import numpy as np

def analyze_audio(audio_path):
    y, sr = librosa.load(audio_path)

    pitch = librosa.yin(y, fmin=50, fmax=300)
    mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13)

    pitch_mean = np.mean(pitch)
    print(f"Average Pitch: {pitch_mean:.2f}")

    if pitch_mean < 75 or pitch_mean > 250:
        print("⚠️ Possible deepfake detected in voice!")
