import { StrictMode, Suspense } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import { createBrowserRouter, RouterProvider } from "react-router";
import "./utils/i18n";

import LandingPage from "./pages/LandingPage";
import SignInPage from "./pages/SignInPage";
import NotFoundPage from "./pages/NotFoundPage";

import TeacherOverviewPage from "./pages/teacher/overview-page";
import TeacherCreateAssessmentPage from "./pages/teacher/create-assessment-page";
import TeacherAssessmentsPage from "./pages/teacher/assessments-list-page";
import TeacherSchedulePage from "./pages/teacher/schedule-page";
import TeacherResourcesPage from "./pages/teacher/resources-page";
import TeacherStudentsPage from "./pages/teacher/students-page";
import TeacherResultsAnalyticsPage from "./pages/teacher/result-analytics-page";
import TeacherUserPage from "./pages/teacher/user-profile-page";

import AdminOverviewPage from "./pages/admin/overview-page";
import AdminStudentsPage from "./pages/admin/students-page";
import AdminTeachersPage from "./pages/admin/teachers-page";
import AdminExamAdminsPage from "./pages/admin/exam-admins-page";
import AdminAssessmentsPage from "./pages/admin/assessments-page";
import AdminExamSchedulePage from "./pages/admin/exam-schedule-page";
import AdminInstitutionPage from "./pages/admin/institution-page";

const router = createBrowserRouter([
  {
    path: "/",
    element: <LandingPage />,
    errorElement: <NotFoundPage />,
  },
  {
    path: "sign-in",
    element: <SignInPage />,
  },
  {
    path: "/teacher",
    element: <TeacherOverviewPage />,
  },
  {
    path: "/teacher/assessments/create",
    element: <TeacherCreateAssessmentPage />,
  },
  {
    path: "/teacher/assessments",
    element: <TeacherAssessmentsPage />,
  },
  {
    path: "/teacher/schedule",
    element: <TeacherSchedulePage />,
  },
  {
    path: "/teacher/resources",
    element: <TeacherResourcesPage />,
  },
  {
    path: "/teacher/students",
    element: <TeacherStudentsPage />,
  },
  {
    path: "/teacher/result-analytics",
    element: <TeacherResultsAnalyticsPage />,
  },
  {
    path: "/teacher/user",
    element: <TeacherUserPage />,
  },
  {
    path: "/admin",
    element: <AdminOverviewPage />,
  },
  {
    path: "/admin/students",
    element: <AdminStudentsPage />,
  },
  {
    path: "/admin/teachers",
    element: <AdminTeachersPage />,
  },
  {
    path: "/admin/exam-admins",
    element: <AdminExamAdminsPage />,
  },
  {
    path: "/admin/assessments",
    element: <AdminAssessmentsPage />,
  },
  {
    path: "/admin/exam-schedule",
    element: <AdminExamSchedulePage />,
  },
  {
    path: "/admin/institution",
    element: <AdminInstitutionPage />,
  },
]);

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <Suspense fallback={<div>Loading...</div>}>
      <RouterProvider router={router} />
    </Suspense>
  </StrictMode>
);
