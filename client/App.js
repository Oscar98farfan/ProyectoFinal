import { StatusBar } from 'expo-status-bar';
import { useEffect, useState } from 'react';
import { FlatList, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import Task from "./components/Task";
import { BottomSheetModalProvider } from "@gorhom/bottom-sheet";
import InputTask from "./components/InputTask";


export default function App() {
  const [todos, setTodos] = useState();

useEffect(() => {
  fetchData();
},[])


  async function fetchData(){
    const response = await fetch("http://localhost:8080/todos/1");
    const data = await response.json();
    setTodos(data);
  }

  return (
    <BottomSheetModalProvider>
      <View style={styles.container}>
        <SafeAreaView>
          <FlatList
            data = {todos}
            keyExtractor={(todo) => todo.id}
            renderItem={({ item }) => (
              <Task {...item} toggleTodo={toggleTodo} clearTodo={clearTodo} />
            )}
            ListHeaderComponent={() => <Text style={styles.title}>Today</Text>}
            contentContainerStyle = {styles.contentContainerStyle}
          />
        </SafeAreaView>
        <StatusBar style="auto" />
      </View>
    </BottomSheetModalProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  contentContainerStyle: {
    padding: 20,
  },
  title: {
    marginTop: 25,
    fontWeight: "bold",
    fontSize: 62,
    marginBottom: 20,
  },
});
