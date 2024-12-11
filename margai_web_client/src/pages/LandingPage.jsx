import { MenuIcon } from "lucide-react";

function LandingPage() {
  return (
    <div className="bg-[#F0F7FF] w-screen h-screen">
      <nav
        className="bg-white w-32 items-center justify-center p-8"
        style={{
          borderRadius: "0rem 2.0625rem 2.0625rem 0rem",
          border: "1px solid rgba(0, 119, 255, 0.66)",
        }}
      >
        <div className="flex flex-col  items-center justify-center gap-10">
          <MenuIcon />
          <MenuIcon />
          <MenuIcon />
          <MenuIcon />
        </div>
      </nav>

      <div className="bg-[#1B7BAB] flex flex-col items-center justify-center rounded-3xl mx-8 p-16 gap-6 ml-36">
        <h1 className="text-white text-2xl font-bold">Welcome to MargAI</h1>
        <p className="text-white text-base">
          Empowering education through technology
        </p>
      </div>
    </div>
  );
}

export default LandingPage;
