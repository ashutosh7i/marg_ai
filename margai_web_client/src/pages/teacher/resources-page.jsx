import Sidebar from "@/components/teacher/Sidebar";
import Header from "@/components/teacher/Header";

function ResourcesPage() {
  return (
    <>
      <Sidebar />
      <div className="ml-[16.975rem] bg-[#F3F4FF]">
        <Header title="Resources" />
      </div>

      <div className="ml-[16.975rem] h-screen bg-[#F3F4FF]">
        {/* Upload study material */}
        <div className="mx-auto max-w-xl rounded-xl bg-white p-6 shadow-sm">
          <h2 className="mb-4 text-xl font-bold text-[#303972]">
            Upload Document
          </h2>
          <div className="space-y-4">
            <div>
              <label className="mb-2 block text-sm font-medium text-[#303972]">
                Title
              </label>
              <input
                type="text"
                className="w-full rounded-lg border border-gray-300 p-2.5 text-[#303972] focus:border-blue-500 focus:outline-none"
                placeholder="Enter document title"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm font-medium text-[#303972]">
                Upload File
              </label>
              <div className="flex w-full items-center justify-center">
                <label className="flex h-32 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed border-gray-300 bg-gray-50 hover:bg-gray-100">
                  <div className="flex flex-col items-center justify-center pb-6 pt-5">
                    <svg
                      className="mb-3 h-10 w-10 text-gray-400"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                      />
                    </svg>
                    <p className="mb-2 text-sm text-gray-500">
                      <span className="font-semibold">Click to upload</span> or
                      drag and drop
                    </p>
                    <p className="text-xs text-gray-500">
                      PDF, DOC, PPT (MAX. 10MB)
                    </p>
                  </div>
                  <input type="file" className="hidden" />
                </label>
              </div>
            </div>
            <button className="w-full rounded-lg bg-[#303972] px-5 py-2.5 text-center text-sm font-medium text-white hover:bg-[#262e5c] focus:outline-none">
              Upload Document
            </button>
          </div>
        </div>

        {/* Upload lectures */}

        {/* Class list */}

        {/* Lecture notes */}

        {/* View assignments button */}
      </div>
    </>
  );
}

export default ResourcesPage;
