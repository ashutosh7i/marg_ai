/* eslint-disable react/prop-types */
import LanguageSelector from "./LanguageSelector";
import AdminAvatar from "./AdminAvatar";

function Header({ heading }) {
  return (
    <header className="ml-[16.975rem] flex items-center justify-between bg-[#E8F9F9] px-10 py-6">
      <h1 className="text-4xl font-bold text-[#00494A]">{heading}</h1>
      <div className="flex items-center gap-12">
        <LanguageSelector />
        <AdminAvatar />
      </div>
    </header>
  );
}

export default Header;
