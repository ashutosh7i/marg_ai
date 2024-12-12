import Header from "@/components/admin/Header";
import Sidebar from "@/components/admin/Sidebar";
import EditableField from "@/components/EditableField";
import { Mail, Pencil, PhoneCall } from "lucide-react";
import { useState } from "react";

function InstitutionPage() {
  const handleImageUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
      //TODO: Handle the file upload here
      console.log("File selected:", file);
    }
  };

  const [instituteData, setInstituteData] = useState({
    instituteName: "Institute_Name",
    website: "institutewebsite.com",
    address: "468 Sitio Tokok, Bacayao Sur, Dagupan City, Pangasinan",
    email: "Institutemail@gmail.com",
    telephoneNumber: "(125) 545-5245",
    password: "lalalala",
  });

  const handleEdit = (field, value) => {
    setInstituteData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  return (
    <>
      <Sidebar />
      <Header heading={"Exam Schedule"} />

      <main className="ml-[16.975rem] bg-[#E8F9F9] h-screen pt-10">
        <div className="mx-20 relative">
          <h2 className="font-italic font-roboto mb-4 text-xl font-normal text-[#555]">
            Edit details
          </h2>
          <div
            className="mb-8 rounded-lg bg-white"
            style={{ boxShadow: "0px 0px 10px 0px rgba(0, 0, 0, 0.1)" }}
          >
            <div className="space-y-4 p-6 pl-12">
              <EditableField
                value={instituteData.instituteName}
                onEdit={(value) => handleEdit("instituteName", value)}
                icon={<Pencil className="h-4 w-4 text-gray-500" />}
                className="text-2xl font-semibold text-gray-800"
              />

              <EditableField
                value={instituteData.website}
                onEdit={(value) => handleEdit("website", value)}
                icon={<Pencil className="h-4 w-4 text-gray-500" />}
                className="text-gray-600"
              />
            </div>
          </div>

          <h2 className="font-italic font-roboto mb-4 text-xl font-normal text-[#555]">
            Address
          </h2>
          <div
            className="mb-8 rounded-lg bg-white"
            style={{ boxShadow: "0px 0px 10px 0px rgba(0, 0, 0, 0.1)" }}
          >
            <div className="space-y-4 p-6 pl-12">
              <EditableField
                value={instituteData.address}
                onEdit={(value) => handleEdit("address", value)}
                icon={<Pencil className="h-4 w-4 text-gray-500" />}
                className="text-gray-600"
              />
            </div>
          </div>

          <h2 className="font-italic font-roboto mb-4 text-xl font-normal text-[#555]">
            Contact Details
          </h2>
          <div
            className="rounded-lg bg-white"
            style={{ boxShadow: "0px 0px 10px 0px rgba(0, 0, 0, 0.1)" }}
          >
            <div className="space-y-4 p-6 pl-12">
              <EditableField
                value={instituteData.email}
                onEdit={(value) => handleEdit("email", value)}
                icon={<Pencil className="h-4 w-4 text-gray-500" />}
                leftIcon={<Mail className="h-5 w-5 pr-1.5 text-gray-500" />}
                className="text-gray-800"
              />

              <EditableField
                value={instituteData.telephoneNumber}
                onEdit={(value) => handleEdit("telephoneNumber", value)}
                icon={<Pencil className="h-4 w-4 text-gray-500" />}
                leftIcon={
                  <PhoneCall className="h-5 w-5 pr-1.5 text-gray-500" />
                }
                className="text-gray-600"
              />
            </div>
          </div>

          {/**
           *
           * Profile Avatar
           *
           */}
          <div className="absolute right-[2rem] top-[-2rem] flex flex-col items-center justify-center">
            <div className="relative">
              <label htmlFor="profile-upload" className="cursor-pointer">
                <div className="group relative h-36 w-36 overflow-hidden rounded-full border-4 border-[#018183] bg-[#0181836B]/50">
                  <img
                    src="/img/avatar.png"
                    alt="User Profile Avatar"
                    className="m-auto h-auto w-[6rem]"
                  />
                  <div className="absolute inset-0 flex items-center justify-center bg-black/50 opacity-0 transition-opacity group-hover:opacity-100">
                    <span className="text-sm text-white">Change Photo</span>
                  </div>
                </div>
              </label>

              <input
                type="file"
                id="profile-upload"
                accept="image/png, image/jpeg"
                onChange={handleImageUpload}
                className="hidden"
              />
            </div>
          </div>
        </div>
      </main>
    </>
  );
}

export default InstitutionPage;
