import { useState } from "react";
import Sidebar from "@/components/admin/Sidebar";
import Header from "@/components/admin/Header";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import {
  Drawer,
  DrawerContent,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

function ExamAdminsPage() {
  const [examAdmins, setExamAdmins] = useState([
    {
      id: 1,
      name: "John Doe",
      email: "john@example.com",
      password: "password123",
    },
  ]);

  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [newExamAdmin, setNewExamAdmin] = useState({
    name: "",
    email: "",
    password: "",
  });

  const handleAddExamAdmin = (e) => {
    e.preventDefault();
    // Add validation and API call here
    setExamAdmins([
      ...examAdmins,
      { ...newExamAdmin, id: examAdmins.length + 1 },
    ]);
    setNewExamAdmin({ name: "", email: "", password: "" });
    setIsDrawerOpen(false);
  };

  return (
    <div className="h-screen">
      <Sidebar />
      <Header heading="Exam Admins" />
      <div className="ml-[16.975rem] bg-[#E8F9F9] h-full pb-8 flex-1 p-8">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold">Exam Admins List</h2>
          <Drawer open={isDrawerOpen} onOpenChange={setIsDrawerOpen}>
            <DrawerTrigger asChild>
              <Button>Add New Exam Admin</Button>
            </DrawerTrigger>
            <DrawerContent>
              <DrawerHeader>
                <DrawerTitle>Add New Exam Admin</DrawerTitle>
              </DrawerHeader>
              <form onSubmit={handleAddExamAdmin} className="p-6 space-y-4">
                <div>
                  <Label htmlFor="name">Name</Label>
                  <Input
                    id="name"
                    type="text"
                    value={newExamAdmin.name}
                    onChange={(e) =>
                      setNewExamAdmin({ ...newExamAdmin, name: e.target.value })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    type="email"
                    value={newExamAdmin.email}
                    onChange={(e) =>
                      setNewExamAdmin({
                        ...newExamAdmin,
                        email: e.target.value,
                      })
                    }
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="password">Password</Label>
                  <Input
                    id="password"
                    type="password"
                    value={newExamAdmin.password}
                    onChange={(e) =>
                      setNewExamAdmin({
                        ...newExamAdmin,
                        password: e.target.value,
                      })
                    }
                    required
                  />
                </div>
                <Button type="submit" className="w-full">
                  Add Exam Admin
                </Button>
              </form>
            </DrawerContent>
          </Drawer>
        </div>

        <div className="rounded-md border">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Name</TableHead>
                <TableHead>Email</TableHead>
                <TableHead>Password</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {examAdmins.map((admin) => (
                <TableRow key={admin.id}>
                  <TableCell>{admin.name}</TableCell>
                  <TableCell>{admin.email}</TableCell>
                  <TableCell>{admin.password}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </div>
    </div>
  );
}

export default ExamAdminsPage;
