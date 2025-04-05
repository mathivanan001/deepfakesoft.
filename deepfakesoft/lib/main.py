from Voice_Deepfake import analyze_audio
from face_detection import analyze_video

def run_detection():
    print("\n🔍 Running Deepfake & Voice Scam Detection...\n")

    print("🎥 Checking video...")
    analyze_video("data/test_video.mp4")

    print("\n🎙️ Checking audio...")
    analyze_audio("data/test_voice.wav")

if __name__ == "__main__":
    run_detection()
