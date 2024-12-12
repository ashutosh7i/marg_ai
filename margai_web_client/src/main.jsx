import { StrictMode, Suspense } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import { createBrowserRouter, RouterProvider } from "react-router";
import "./utils/i18n";

import LandingPage from "./pages/LandingPage";
import SignInPage from "./pages/SignInPage";
import NotFoundPage from "./pages/NotFoundPage";

import TeacherOverviewPage from "./pages/teacher/overview-page";
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
import AddVivaPage from "./pages/teacher/add-viva-page";
import AddMCQPage from "./pages/teacher/add-mcq-page";
import AddDescriptivePage from "./pages/teacher/add-descriptive-page";
import GenerateQuestionsPage from "./pages/teacher/generate-questions-page";
import OverviewPage from "./pages/exam-admin/overview-page";
import ExamAdminAssignmentsPage from "./pages/exam-admin/assignments-page";

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
    path: "/teacher/assessments",
    element: <TeacherAssessmentsPage />,
  },
  {
    path: "/teacher/assessments/add-viva",
    element: <AddVivaPage />,
  },
  {
    path: "/teacher/assessments/add-mcq",
    element: <AddMCQPage />,
  },
  {
    path: "/teacher/assessments/add-descriptive",
    element: <AddDescriptivePage />,
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
    path: "/teacher/generate-questions",
    element: <GenerateQuestionsPage />,
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
  {
    path: "/exam-admin",
    element: <OverviewPage />,
  },
  {
    path: "/exam-admin/assignments",
    element: <ExamAdminAssignmentsPage />,
  },
]);

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <Suspense fallback={<div>Loading...</div>}>
      <RouterProvider router={router} />
    </Suspense>
  </StrictMode>
);
