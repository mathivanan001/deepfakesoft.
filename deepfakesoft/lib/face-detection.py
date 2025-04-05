import cv2
import dlib
import mediapipe as mp

detector = dlib.get_frontal_face_detector()
mp_face_mesh = mp.solutions.face_mesh.FaceMesh(static_image_mode=False)

def analyze_video(video_path):
    cap = cv2.VideoCapture(video_path)
    
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = detector(gray)

        for face in faces:
            landmarks = mp_face_mesh.process(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
            if landmarks.multi_face_landmarks:
                print("✅ Facial landmarks detected.")


    cap.release()
    cv2.destroyAllWindows()

