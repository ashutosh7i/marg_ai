import { Link, useLocation } from "react-router";

function Sidebar() {
  const { pathname } = useLocation();

  const menuItems = [
    {
      id: 1,
      name: "Overview",
      activeIcon: "/img/teacher-sidebar/overview-active.svg",
      inactiveIcon: "/img/teacher-sidebar/overview.svg",
      path: "/exam-admin",
    },
    {
      id: 2,
      name: "Assessments",
      activeIcon: "/img/teacher-sidebar/students-active.svg",
      inactiveIcon: "/img/teacher-sidebar/students.svg",
      path: "/exam-admin/assessments",
    },
  ];

  const isActiveRoute = (menuPath) => {
    console.log(menuPath, pathname);

    if (menuPath === "/exam-admin") {
      return pathname === "/exam-admin";
    }
    return pathname.startsWith(menuPath);
  };

  return (
    <section className="fixed flex h-screen w-[16.975rem] flex-col items-center border border-[#1B2E59] border-r-[#F3F4FF] bg-[#1B2E59] pt-8">
      <Link
        to="/exam-admin"
        className="flex h-[2.88656rem] items-center pl-6 justify-center gap-2"
      >
        <img src="/img/logo.svg" alt="logo" height={45} width={45} />
        <h1 className="font-poppins lead text-[2rem] font-bold text-white">
          {/* {t("Title")} */}
          Marg AI
        </h1>
      </Link>

      <nav className="mt-4 flex flex-col gap-2 pl-4 w-full">
        {menuItems.map((menu) => (
          <Link
            to={menu.path}
            key={menu.id}
            className={`group w-full flex items-center gap-6 rounded-s-[2.5rem] px-6 py-2 text-lg font-medium hover:bg-[#F3F4FF] hover:text-[#1B2E59] ${
              isActiveRoute(menu.path)
                ? "bg-[#E2EBFF] text-[#1B2E59]"
                : "text-white"
            }`}
          >
            <img
              src={
                isActiveRoute(menu.path) || false
                  ? menu.activeIcon
                  : menu.inactiveIcon
              }
              className={`${
                !isActiveRoute(menu.path) ? "group-hover:hidden" : ""
              }`}
              alt={menu.name}
            />
            {!isActiveRoute(menu.path) && (
              <img
                src={menu.activeIcon}
                className="hidden group-hover:block"
                alt={menu.name}
              />
            )}
            <h2>{menu.name}</h2>
          </Link>
        ))}
      </nav>
    </section>
  );
}

export default Sidebar;
