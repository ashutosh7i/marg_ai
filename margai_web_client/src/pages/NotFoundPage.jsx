import { useNavigate } from "react-router";

function NotFoundPage() {
  const navigate = useNavigate();

  return (
    <div className="flex h-screen flex-col items-center justify-center gap-4 bg-[#F3F4FF]">
      <h1 className="text-9xl font-bold text-[#4D44B5]">404</h1>
      <h2 className="text-2xl font-semibold text-[#303972]">Page Not Found</h2>
      <p className="text-[#A098AE]">
        The page you&apos;re looking for doesn&apos;t exist.
      </p>
      <button
        onClick={() => navigate(-1)}
        className="mt-4 rounded-full bg-[#4D44B5] px-6 py-2 text-white hover:bg-[#4D44B5]/80"
      >
        Go Back
      </button>
    </div>
  );
}

export default NotFoundPage;
